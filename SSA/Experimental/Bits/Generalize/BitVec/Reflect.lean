import Lean.Elab.Term
import Lean

import SSA.Core.Util
import SSA.Experimental.Bits.Generalize.Generalize
import SSA.Experimental.Bits.Generalize.BitVec.Basic

namespace Generalize

open Lean
open Lean.Meta
open Std.Sat
open Std.Tactic.BVDecide
open Tactic

def defaultParsedExprState : ParsedInputState := { maxFreeVarId := 0
                                                                 , numSymVars := 0, originalWidth := 32
                                                                , inputVarIdToDisplayName := {}, symVarToVal := {}
                                                                , symVarToDisplayName := {}, displayNameToVariable := {}, valToSymVar:= {}}

def printParsedBVExprState (s: ParsedInputState) :=
    s!"ParsedBVExprState:\n" ++
    s!"  maxFreeVarId: {s.maxFreeVarId}\n" ++
    s!"  numSymVars: {s.numSymVars}\n" ++
    s!"  displayNameToVariable: {s.displayNameToVariable}\n" ++
    s!"  BVExprIdToFreeVar: {s.inputVarIdToDisplayName}\n" ++
    s!"  symVarToVal: {s.symVarToVal}" ++
    s!"  symVarToDisplayName: {s.symVarToDisplayName}"


instance : ToMessageData (ParsedInputState) where
  toMessageData s := printParsedBVExprState s


instance : ToString (ParsedInputState) where
  toString s := printParsedBVExprState s


structure ParsedBVExpr where
  width : Nat
  bvExpr: GenBVExpr width
  symVars: Std.HashMap Nat BVExpr.PackedBitVec
  inputVars : Std.HashMap Nat Name

abbrev ParsedBVLogicalExpr := ParsedLogicalExpr ParsedBVExpr GenBVLogicalExpr

partial def toBVExpr (expr : Expr) (width: Nat) : ParseExprM (Option (BVExprWrapper)) := do
  go expr
  where

  go (x : Expr) : ParseExprM (Option (BVExprWrapper)) := do
    match_expr x with
    | HAnd.hAnd _ _ resType _ lhsExpr rhsExpr =>
        binaryReflection lhsExpr rhsExpr resType BVBinOp.and
    | HXor.hXor _ _ resType _ lhsExpr rhsExpr =>
        binaryReflection lhsExpr rhsExpr resType BVBinOp.xor
    | HAdd.hAdd _ _ resType _ lhsExpr rhsExpr =>
        binaryReflection lhsExpr rhsExpr resType BVBinOp.add
    | HOr.hOr _ _ resType _ lhsExpr rhsExpr =>
        binaryReflection lhsExpr rhsExpr resType BVBinOp.or
    | HSub.hSub _ _ resType _ lhsExpr rhsExpr =>
        let some lhs ← go lhsExpr | return none
        let some rhs ← go rhsExpr | return none
        let some w ← getWidth? resType | return none
        if h : lhs.width = w ∧ rhs.width = lhs.width then
          let rhs' := h.right ▸ rhs.bvExpr
          return some {bvExpr := subtract lhs.bvExpr rhs', width := lhs.width}
        else
          return none
    | HMul.hMul _ _ resType _ lhsExpr rhsExpr =>
        binaryReflection lhsExpr rhsExpr resType BVBinOp.mul
    | HDiv.hDiv _ _ resType _ lhsExpr rhsExpr =>
        binaryReflection lhsExpr rhsExpr resType BVBinOp.udiv
    | HMod.hMod _ _ resType _ lhsExpr rhsExpr =>
        binaryReflection lhsExpr rhsExpr resType BVBinOp.umod
    | Complement.complement _ _ innerExpr => --TODO:
        let some inner ← go innerExpr | return none
        return some {bvExpr := GenBVExpr.un BVUnOp.not inner.bvExpr, width := inner.width}
    | HShiftLeft.hShiftLeft _ _ resType _ innerExpr distanceExpr =>
        shiftReflection innerExpr distanceExpr resType GenBVExpr.shiftLeft
    | HShiftRight.hShiftRight _ _ resType _ innerExpr distanceExpr =>
        shiftReflection innerExpr distanceExpr resType GenBVExpr.shiftRight
    | BitVec.sshiftRight _ resType innerExpr distanceExpr =>
        shiftReflection innerExpr distanceExpr resType GenBVExpr.arithShiftRight
    | BitVec.sshiftRight' _ resType innerExpr distanceExpr =>
        shiftReflection innerExpr distanceExpr resType GenBVExpr.arithShiftRight
    | HAppend.hAppend _ _ _ _ lhsExpr rhsExpr =>
        let some lhs ← go lhsExpr | return none
        let some rhs ← go rhsExpr | return none
        return some {bvExpr := GenBVExpr.append lhs.bvExpr rhs.bvExpr rfl, width := _}
    | BitVec.extractLsb' _ _ _ _ =>
        throwError m! "Does not support BitVec.extractLsb' operations"
    | BitVec.rotateLeft resType innerExpr distanceExpr =>
        rotateReflection innerExpr distanceExpr resType BVUnOp.rotateLeft
    | BitVec.rotateRight resType innerExpr distanceExpr =>
        rotateReflection innerExpr distanceExpr resType BVUnOp.rotateRight
    | BitVec.signExtend _ vExpr xExpr =>
        let some v ← getNatValue? vExpr | return none
        let some x ← go xExpr | return none
        return some {bvExpr := GenBVExpr.signExtend v x.bvExpr, width := v}
    | BitVec.zeroExtend _ vExpr xExpr =>
        let some v ← getNatValue? vExpr | return none
        let some x ← go xExpr | return none
        return some {bvExpr := GenBVExpr.zeroExtend v x.bvExpr, width := v}
    | BitVec.truncate _ vExpr xExpr =>
      let some v ← getNatValue? vExpr | return none
      let some x ← go xExpr | return none
      return some {bvExpr := GenBVExpr.truncate v x.bvExpr, width := _}
    | Neg.neg _ _ a =>
          let some (bvProd) ← getBitVecValue? a| return none
          let pbv := {bv := -bvProd.snd: BVExpr.PackedBitVec}

          return (← processBitVec pbv)

    | _ =>
        let natVal ← getNatValue? x
        let bitVecVal ← getBitVecValue? x

        match (natVal, bitVecVal) with
        | (some v, none) =>
              let currState: ParsedInputState  ← get
              let pbv : BVExpr.PackedBitVec := {bv := BitVec.ofNat currState.originalWidth v}
              let existingVal :=  currState.valToSymVar[pbv]?

              match existingVal with
              | none => let numSymVars := currState.numSymVars
                        let newId := 1001 + numSymVars
                        let newExpr : GenBVExpr width := GenBVExpr.var newId
                        let userFacingName := Lean.Name.mkSimple s!"C{numSymVars + 1}"
                        let var : HydraVariable := {name := userFacingName, id := newId, width := width}

                        let updatedState : ParsedInputState  := { currState with
                                                                numSymVars := numSymVars + 1
                                                                , symVarToVal := currState.symVarToVal.insert newId pbv
                                                                , valToSymVar := currState.valToSymVar.insert pbv newId
                                                                , displayNameToVariable := currState.displayNameToVariable.insert userFacingName var
                                                                , symVarToDisplayName := currState.symVarToDisplayName.insert newId userFacingName}
                        set updatedState
                        return some {bvExpr := newExpr, width := width}
              | some var => let newExpr : GenBVExpr width := GenBVExpr.var var
                            return some {bvExpr := newExpr, width := width}

        | (none, some bvProd) =>
              let pbv : BVExpr.PackedBitVec := {bv := bvProd.snd: BVExpr.PackedBitVec}
              return (← processBitVec pbv)
        | _ =>
            let currState: ParsedInputState ← get
            let localDecl ← getFVarLocalDecl x
            let userFacingName := localDecl.userName
            let some w ← getWidth? localDecl.type | return none

            let existingVar? := currState.displayNameToVariable[userFacingName]?
            match existingVar? with
            | some val => return some {bvExpr := GenBVExpr.var val.id, width := val.width}
            | none =>
                let newId := currState.maxFreeVarId + 1
                let newExpr : GenBVExpr w :=  GenBVExpr.var newId
                let newWrappedExpr : BVExprWrapper := {bvExpr := newExpr, width := w}

                let var : HydraVariable := {name := userFacingName, id := newId, width := width}

                let updatedState : ParsedInputState :=  { currState with
                                                         maxFreeVarId := newId
                                                         , displayNameToVariable := currState.displayNameToVariable.insert userFacingName var
                                                         , inputVarIdToDisplayName := currState.inputVarIdToDisplayName.insert newId userFacingName
                                                         }
                set updatedState
                return some newWrappedExpr

  rotateReflection (innerExpr distanceExpr resType: Expr) (rotateOp: Nat → BVUnOp)
          : ParseExprM (Option (BVExprWrapper)) := do
      let some inner ← go innerExpr | return none
      let some distance ← getNatValue? distanceExpr | return none
      let some w ← getWidth? resType | return none

      if w == inner.width then
        return some {bvExpr := GenBVExpr.un (rotateOp distance) inner.bvExpr, width := inner.width}
      else return none

  binaryReflection (lhsExpr rhsExpr resType : Expr) (op : BVBinOp) : ParseExprM (Option (BVExprWrapper)) := do
    let some lhs ← go lhsExpr | return none
    let some rhs ← go rhsExpr | return none
    let some w ← getWidth? resType | return none

    if h : w = lhs.width ∧ lhs.width = rhs.width then
      let rhs' := h.right ▸ rhs.bvExpr
      return some {bvExpr := GenBVExpr.bin lhs.bvExpr op rhs', width := lhs.width}
    else
      return none

  shiftReflection (innerExpr distanceExpr resType: Expr) (shiftOp : {m n : Nat} → GenBVExpr m → GenBVExpr n → GenBVExpr m)
        : ParseExprM (Option (BVExprWrapper)) := do
      let some inner ← go innerExpr | return none
      let some distance ← go distanceExpr | return none
      let some w ← getWidth? resType | return none

      if w == inner.width then
        return some {bvExpr :=  shiftOp inner.bvExpr distance.bvExpr, width := inner.width}
      else return none


  getConstantBVExpr? (nExpr : Expr) (vExpr : Expr) : ParseExprM (Option (BVExprWrapper)) := do
        let some n  ← getNatValue? nExpr | return none
        let some v ← getNatValue? vExpr | return none

        return some {bvExpr := GenBVExpr.const (BitVec.ofNat n v), width := n}

  getBitVecValue? (e : Expr) : MetaM (Option ((n : Nat) × BitVec n)) := OptionT.run do
    match_expr e with
    | BitVec.ofNat nExpr vExpr =>
      let n ← getNatValue? nExpr
      let v ← getNatValue? vExpr
      return ⟨n, BitVec.ofNat n v⟩
    | BitVec.ofNatLT nExpr vExpr _ =>
      let n ← getNatValue? nExpr
      let v ← getNatValue? vExpr
      return ⟨n, BitVec.ofNat n v⟩
    | BitVec.ofInt nExpr vExpr =>
      let n ← getNatValue? nExpr
      let v ← getIntValue? vExpr
      return ⟨n, BitVec.ofInt n v⟩
    -- | BitVec.ofBool b =>
    --    return ⟨1, e⟩
    | BitVec.allOnes nExpr =>
      let n ← getNatValue? nExpr
      return ⟨n, BitVec.allOnes n⟩
    | _ =>
      let (v, type) ← getOfNatValue? e ``BitVec
      let n ← getNatValue? (← whnfD type.appArg!)
      return ⟨n, BitVec.ofNat n v⟩

  getWidth? (type : Expr) : MetaM (Option Nat) := do
    match_expr type with
    | BitVec n => getNatValue? n
    | _ => pure none

  processBitVec (pbv : BVExpr.PackedBitVec) : ParseExprM (Option BVExprWrapper) := do
    let currState: ParsedInputState ← get
    let existingVal :=  currState.valToSymVar[pbv]?
    match existingVal with
    | none =>
      let numSymVars := currState.numSymVars
      let newId := 1001 + numSymVars
      let newExpr : GenBVExpr pbv.w := GenBVExpr.var newId

      let userFacingName := Lean.Name.mkSimple s!"C{numSymVars + 1}"
      let var : HydraVariable := {name := userFacingName, id := newId, width := pbv.w}

      let updatedState : ParsedInputState := { currState with
                                              numSymVars := numSymVars + 1
                                              , symVarToVal := currState.symVarToVal.insert newId pbv
                                              , valToSymVar := currState.valToSymVar.insert pbv newId
                                              , displayNameToVariable := currState.displayNameToVariable.insert userFacingName var
                                              , symVarToDisplayName := currState.symVarToDisplayName.insert newId userFacingName}
      set updatedState
      return some {bvExpr := newExpr, width := pbv.w}
    | some var => let newExpr : GenBVExpr pbv.w := GenBVExpr.var var
                  return some {bvExpr := newExpr, width := pbv.w}


def parseExprs (lhsExpr rhsExpr : Expr) (width : Nat): ParseExprM (Option ParsedBVLogicalExpr)  := do
  let some lhsRes ← toBVExpr lhsExpr width | throwError "Could not extract lhs: {lhsExpr}"

  let state ← get
  let lhs: ParsedBVExpr := {bvExpr := lhsRes.bvExpr, width := lhsRes.width, symVars := state.symVarToVal, inputVars := state.inputVarIdToDisplayName}

  let some rhsRes ← toBVExpr rhsExpr width | throwError "Could not extract rhs: {rhsExpr}"
  let state ← get

  let rhsInputVars := state.inputVarIdToDisplayName.filter fun k _ => !lhs.inputVars.contains k
  let rhsSymVars := state.symVarToVal.filter fun k _ => !lhs.symVars.contains k

  let rhs: ParsedBVExpr := {bvExpr := rhsRes.bvExpr, width := rhsRes.width, symVars := rhsSymVars, inputVars := rhsInputVars}

  trace[Generalize] m! "lhs width: {lhsRes.width}; rhs width: {rhsRes.width}"
  if h : lhsRes.width = rhsRes.width then
    let rhsExpr := h ▸ rhsRes.bvExpr
    let bvLogicalExpr := BoolExpr.literal (GenBVPred.bin lhsRes.bvExpr BVBinPred.eq rhsExpr)
    trace[Generalize] m! "BVLogicalExpr: {bvLogicalExpr}"

    return some {lhs := lhs, rhs := rhs, state := state, logicalExpr := bvLogicalExpr}

  return none

def mkHShift (name : Name) (w n : Nat) (synthName : Name) (lhs rhs : Expr) : Expr :=
  let bitVecW := mkApp (mkConst ``BitVec) (mkNatLit w)
  let bitVecN := mkApp (mkConst ``BitVec) (mkNatLit n)
  let synthInstance := (mkApp2 (.const synthName []) (mkNatLit w) (mkNatLit n)) -- bitVecW bitVecN bitVecW)
  mkApp6 (.const name [levelZero, levelZero, levelZero]) bitVecW bitVecN bitVecW synthInstance lhs rhs


def bvExprToExpr (parsedBVExpr : ParsedBVLogicalExpr)
  (bvExpr : GenBVExpr w)  : MetaM Expr := do
  let parsedBVExprState := parsedBVExpr.state
  let allNames := Std.HashMap.union parsedBVExprState.inputVarIdToDisplayName parsedBVExprState.symVarToDisplayName

  let bitVecWidth := (mkNatLit w)
  match bvExpr with
  | .var idx => let localDecl ← getLocalDeclFromUserName allNames[idx]!
                pure (mkFVar localDecl.fvarId)
  | .const (w := w) val => mkAppM ``BitVec.ofInt #[(mkNatLit w),  (mkIntLit val.toInt)]
  | .bin lhs op rhs  => match op with
                        | .and => return mkApp3 (.const ``BitVec.and []) bitVecWidth (← bvExprToExpr parsedBVExpr lhs) (← bvExprToExpr parsedBVExpr rhs)
                        | .or =>  return mkApp3 (.const ``BitVec.or [])  bitVecWidth (← bvExprToExpr parsedBVExpr lhs) (← bvExprToExpr parsedBVExpr rhs)
                        | .xor => return mkApp3 (.const ``BitVec.xor []) bitVecWidth (← bvExprToExpr parsedBVExpr lhs) (← bvExprToExpr parsedBVExpr rhs)
                        | .add => return mkApp3 (.const ``BitVec.add []) bitVecWidth (← bvExprToExpr parsedBVExpr lhs) (← bvExprToExpr parsedBVExpr rhs)
                        | .mul => return mkApp3 (.const ``BitVec.mul []) bitVecWidth (← bvExprToExpr parsedBVExpr lhs) (← bvExprToExpr parsedBVExpr rhs)
                        | .udiv => return mkApp3 (.const ``BitVec.udiv []) bitVecWidth (← bvExprToExpr parsedBVExpr lhs) (← bvExprToExpr parsedBVExpr rhs)
                        | .umod => return mkApp3 (.const ``BitVec.umod []) bitVecWidth (← bvExprToExpr parsedBVExpr lhs) (← bvExprToExpr parsedBVExpr rhs)
  | .un op expr => match op with
                   | .not => return mkApp2 (.const ``BitVec.not []) bitVecWidth (← bvExprToExpr parsedBVExpr expr)
                   | .rotateLeft n => return mkApp3 (.const ``BitVec.rotateLeft []) bitVecWidth (← bvExprToExpr parsedBVExpr expr) (mkNatLit n)
                   | .rotateRight n => return mkApp3 (.const ``BitVec.rotateRight []) bitVecWidth (← bvExprToExpr parsedBVExpr expr) (mkNatLit n)
                   | .arithShiftRightConst n => return mkApp4 (.const ``BitVec.sshiftRight' []) bitVecWidth bitVecWidth (← bvExprToExpr parsedBVExpr expr) (mkNatLit n)
                   | .reverse => return mkApp2 (.const ``BitVec.reverse []) bitVecWidth (← bvExprToExpr parsedBVExpr expr)
                   | .clz => return mkApp2 (.const ``BitVec.clz []) bitVecWidth (← bvExprToExpr parsedBVExpr expr)
  | .append lhs rhs _ => return mkApp3 (.const ``BitVec.append []) bitVecWidth (← bvExprToExpr parsedBVExpr lhs) (← bvExprToExpr parsedBVExpr rhs)
  | .replicate n expr _ => return mkApp3 (.const ``BitVec.replicate []) bitVecWidth (mkNatLit n) (← bvExprToExpr parsedBVExpr expr)
  | .shiftLeft (n := n) lhs rhs => return mkHShift ``HShiftLeft.hShiftLeft w n ``BitVec.instHShiftLeft (← bvExprToExpr parsedBVExpr lhs) (← bvExprToExpr parsedBVExpr rhs)
  | .shiftRight (n := n) lhs rhs => return mkHShift ``HShiftRight.hShiftRight w n ``BitVec.instHShiftRight (← bvExprToExpr parsedBVExpr lhs) (← bvExprToExpr parsedBVExpr rhs)
  | .arithShiftRight (m := m) (n := n) lhs rhs => return mkApp4 (.const ``BitVec.sshiftRight' []) (mkNatLit m) (mkNatLit n) (← bvExprToExpr parsedBVExpr lhs) (← bvExprToExpr parsedBVExpr rhs)
  | .zeroExtend v expr => return mkApp3  (.const ``BitVec.zeroExtend []) bitVecWidth (mkNatLit v) (← bvExprToExpr parsedBVExpr expr)
  | .truncate v expr => return mkApp3  (.const ``BitVec.truncate []) bitVecWidth (mkNatLit v) (← bvExprToExpr parsedBVExpr expr)
  | .signExtend v expr => return mkApp3 (.const ``BitVec.signExtend []) bitVecWidth (mkNatLit v) (← bvExprToExpr parsedBVExpr expr)
  | .extract _ _ _ => throwError m! "Extract operation is not supported."


def beqBitVecInstExpr (width : Expr) : Expr := mkApp2 (.const ``instBEqOfDecidableEq [levelZero]) (mkApp (mkConst ``BitVec) width) (mkApp (.const ``instDecidableEqBitVec []) width)
def beqBoolInstExpr : Expr := mkApp2 (.const ``instBEqOfDecidableEq [levelZero]) (mkConst ``Bool) (mkConst ``instDecidableEqBool)

def toExpr (parsedBVExpr : ParsedBVLogicalExpr) (bvLogicalExpr: GenBVLogicalExpr) (width : Expr) : MetaM Expr := do
  go bvLogicalExpr
  where
  go (input : GenBVLogicalExpr) := do
  match input with
  | .literal (GenBVPred.bin lhs op rhs) =>
      match op with
      | .eq => return mkApp4 (.const ``BEq.beq [levelZero]) (mkApp (mkConst ``BitVec) width) (beqBitVecInstExpr width) (← bvExprToExpr parsedBVExpr lhs) (← bvExprToExpr parsedBVExpr rhs)
      | .ult => return mkApp3 (.const ``BitVec.ult []) width (← bvExprToExpr parsedBVExpr lhs) (← bvExprToExpr parsedBVExpr rhs)
  | .const b =>
      match b with
      | true => return (mkConst ``Bool.true)
      | _ => return (mkConst ``Bool.false)
  | .not boolExpr => return mkApp (.const ``Bool.not []) (← go boolExpr)
  | .gate gate lhs rhs =>
        match gate with
        | .or => return mkApp2 (.const ``Bool.or []) (← go lhs) (← go rhs)
        | .xor => return mkApp2 (.const ``Bool.xor []) (← go lhs) (← go rhs)
        | .and => return mkApp2 (.const ``Bool.and []) (← go lhs) (← go rhs)
        | .beq => return mkApp4 (.const ``BEq.beq [levelZero]) (mkConst ``Bool) (beqBoolInstExpr) (← go lhs) (← go rhs)
  | _ => throwError m! "Unsupported operation"

/- def toBVExpr' (bvExpr : GenBVExpr w) : GeneralizerStateM (BVExpr w) := do
  match bvExpr with
  | .var idx => return BVExpr.var idx
  | .const val => return BVExpr.const val
  | .bin lhs op rhs  => return BVExpr.bin (← toBVExpr' lhs) op (← toBVExpr' rhs)
  | .un op expr =>  return BVExpr.un op (← toBVExpr' expr)
  | .append lhs rhs h => return BVExpr.append (← toBVExpr' lhs) (← toBVExpr' rhs) h
  | .replicate n expr h => return BVExpr.replicate n (← toBVExpr' expr) h
  | .shiftLeft lhs rhs =>  return BVExpr.shiftLeft (← toBVExpr' lhs) (← toBVExpr' rhs)
  | .shiftRight lhs rhs => return BVExpr.shiftRight (← toBVExpr' lhs) (← toBVExpr' rhs)
  | .arithShiftRight lhs rhs =>return BVExpr.arithShiftRight (← toBVExpr' lhs) (← toBVExpr' rhs)
  | _ => throwError m! "Unsupported operation provided: {bvExpr}"


def toBVLogicalExpr (bvLogicalExpr: GenBVLogicalExpr) : GeneralizerStateM BVLogicalExpr := do
  match bvLogicalExpr with
  | .literal (GenBVPred.bin lhs op rhs) => return BoolExpr.literal (BVPred.bin (← toBVExpr' lhs) op (← toBVExpr' rhs))
  | .const b => return BoolExpr.const b
  | .not boolExpr => return BoolExpr.not (← toBVLogicalExpr boolExpr)
  | .gate gate lhs rhs => return BoolExpr.gate gate (← toBVLogicalExpr lhs) (← toBVLogicalExpr rhs)
  | _ => throwError m! "Unsupported operation"
 -/
