import Lean

import SSA.Core.Util
import SSA.Experimental.Bits.Generalize.Basic
import SSA.Experimental.Bits.Generalize.Hydrable
import SSA.Experimental.Bits.Generalize.Generalize

namespace Generalize

open Lean
open Lean.Meta
open Std.Sat
open Std.Tactic.BVDecide

structure ParsedBVExprState where
  maxFreeVarId : Nat
  numSymVars :  Nat
  inputVarToBVExpr : Std.HashMap Name BVExprWrapper
  inputVarIdToDisplayName : Std.HashMap Nat Name
  originalWidth : Nat
  symVarToVal : Std.HashMap Nat BVExpr.PackedBitVec
  symVarToDisplayName : Std.HashMap Nat Name
  valToSymVar : Std.HashMap BVExpr.PackedBitVec Nat

instance : Inhabited ParsedBVExprState where
  default := { maxFreeVarId := 0
             , numSymVars := 0, originalWidth := 32
             , inputVarIdToDisplayName := {}, symVarToVal := {}
             , symVarToDisplayName := {}, inputVarToBVExpr := {}, valToSymVar:= {}}

def printParsedBVExprState (s: ParsedBVExprState) :=
    s!"ParsedBVExprState:\n" ++
    s!"  maxFreeVarId: {s.maxFreeVarId}\n" ++
    s!"  numSymVars: {s.numSymVars}\n" ++
    s!"  freeVarToBVExpr: {s.inputVarToBVExpr}\n" ++
    s!"  BVExprIdToFreeVar: {s.inputVarIdToDisplayName}\n" ++
    s!"  symVarToVal: {s.symVarToVal}" ++
    s!"  symVarToDisplayName: {s.symVarToDisplayName}"

instance : ToMessageData ParsedBVExprState where
  toMessageData s := printParsedBVExprState s


instance : ToString ParsedBVExprState where
  toString s := printParsedBVExprState s


structure ParsedBVExpr where
  width : Nat
  bvExpr: GenBVExpr width
  symVars: Std.HashMap Nat BVExpr.PackedBitVec
  inputVars : Std.HashMap Nat Name

structure ParsedBVLogicalExpr where
  lhs: ParsedBVExpr
  rhs: ParsedBVExpr
  bvLogicalExpr: GenBVLogicalExpr
  state: ParsedBVExprState

abbrev ParseBVExprM := StateRefT ParsedBVExprState MetaM

partial def toBVExpr (expr : Expr) (targetWidth: Nat) : ParseBVExprM (Option (BVExprWrapper)) := do
  go expr
  where

  go (x : Expr) : ParseBVExprM (Option (BVExprWrapper)) := do
    match_expr x with
    | HAnd.hAnd _ _ _ _ lhsExpr rhsExpr =>
        binaryReflection lhsExpr rhsExpr BVBinOp.and
    | HXor.hXor _ _ _ _ lhsExpr rhsExpr =>
        binaryReflection lhsExpr rhsExpr BVBinOp.xor
    | HAdd.hAdd _ _ _ _ lhsExpr rhsExpr =>
        binaryReflection lhsExpr rhsExpr BVBinOp.add
    | HOr.hOr _ _ _ _ lhsExpr rhsExpr =>
        binaryReflection lhsExpr rhsExpr BVBinOp.or
    | HSub.hSub _ _ _ _ lhsExpr rhsExpr =>
        let some lhs ← go lhsExpr | return none
        let some rhs ← go rhsExpr | return none
        if h : lhs.width = rhs.width then
          let rhs' := h ▸ rhs.bvExpr
          return some {bvExpr := subtract lhs.bvExpr rhs', width := lhs.width}
        else
          return none
    | HMul.hMul _ _ _ _ lhsExpr rhsExpr =>
        binaryReflection lhsExpr rhsExpr BVBinOp.mul
    | HDiv.hDiv _ _ _ _ lhsExpr rhsExpr =>
        binaryReflection lhsExpr rhsExpr BVBinOp.udiv
    | HMod.hMod _ _ _ _ lhsExpr rhsExpr =>
        binaryReflection lhsExpr rhsExpr BVBinOp.umod
    | Complement.complement _ _ innerExpr =>
        let some inner ← go innerExpr | return none
        return some {bvExpr := GenBVExpr.un BVUnOp.not inner.bvExpr, width := inner.width}
    | HShiftLeft.hShiftLeft _ _ _ _ innerExpr distanceExpr =>
        shiftReflection innerExpr distanceExpr GenBVExpr.shiftLeft
    | HShiftRight.hShiftRight _ _ _ _ innerExpr distanceExpr =>
        shiftReflection innerExpr distanceExpr GenBVExpr.shiftRight
    | BitVec.sshiftRight _ _ innerExpr distanceExpr =>
        shiftReflection innerExpr distanceExpr GenBVExpr.arithShiftRight
    | BitVec.sshiftRight' _ _ innerExpr distanceExpr =>
        shiftReflection innerExpr distanceExpr GenBVExpr.arithShiftRight
    | HAppend.hAppend _ _ _ _ lhsExpr rhsExpr =>
        let some lhs ← go lhsExpr | return none
        let some rhs ← go rhsExpr | return none
        return some {bvExpr := GenBVExpr.append lhs.bvExpr rhs.bvExpr rfl, width := _}
    | BitVec.extractLsb' _ _ _ _ =>
        throwError m! "Does not support BitVec.extractLsb' operations"
    | BitVec.rotateLeft _ innerExpr distanceExpr =>
        rotateReflection innerExpr distanceExpr BVUnOp.rotateLeft
    | BitVec.rotateRight _ innerExpr distanceExpr =>
        rotateReflection innerExpr distanceExpr BVUnOp.rotateRight
    | BitVec.zeroExtend _ nExpr vExpr =>
        let some n ← getNatValue? nExpr | return none
        let some v ← go vExpr | return none
        return some {bvExpr := GenBVExpr.zeroExtend n v.bvExpr, width := _}
    | BitVec.truncate _ nExpr vExpr =>
      let some n ← getNatValue? nExpr | return none
      let some v ← go vExpr | return none
      return some {bvExpr := GenBVExpr.truncate n v.bvExpr, width := _}
    | Neg.neg _ _ a =>
          let some (bvProd) ← getBitVecValue? a| return none
          let pbv := {bv := -bvProd.snd: BVExpr.PackedBitVec}

          return (← processBitVec pbv)

    | _ =>
        let natVal ← getNatValue? x
        let bitVecVal ← getBitVecValue? x

        match (natVal, bitVecVal) with
        | (some v, none) =>
              let currState: ParsedBVExprState ← get
              let pbv : BVExpr.PackedBitVec := {bv := BitVec.ofNat currState.originalWidth v}
              let existingVal :=  currState.valToSymVar[pbv]?

              match existingVal with
              | none => let numSymVars := currState.numSymVars
                        let newId := 1001 + numSymVars
                        let newExpr : GenBVExpr targetWidth := GenBVExpr.var newId

                        let updatedState : ParsedBVExprState := { currState with
                                                                numSymVars := numSymVars + 1
                                                                , symVarToVal := currState.symVarToVal.insert newId pbv
                                                                , valToSymVar := currState.valToSymVar.insert pbv newId
                                                                , symVarToDisplayName := currState.symVarToDisplayName.insert newId (Lean.Name.mkSimple s!"C{numSymVars + 1}")}
                        set updatedState
                        return some {bvExpr := newExpr, width := targetWidth}
              | some var => let newExpr : GenBVExpr targetWidth := GenBVExpr.var var
                            return some {bvExpr := newExpr, width := targetWidth}

        | (none, some bvProd) =>
              let pbv : BVExpr.PackedBitVec := {bv := bvProd.snd: BVExpr.PackedBitVec}
              return (← processBitVec pbv)
        | _ =>
            let currState: ParsedBVExprState ← get
            let .fvar name := x | throwError m! "Unknown expression: {x}"
            let userFacingName := ((← getLCtx).get! name).userName

            let existingVar? := currState.inputVarToBVExpr[userFacingName]?
            match existingVar? with
            | some val => return val
            | none =>
                let newId := currState.maxFreeVarId + 1
                let newExpr : GenBVExpr targetWidth :=  GenBVExpr.var newId
                let newWrappedExpr : BVExprWrapper := {bvExpr := newExpr, width := targetWidth}

                let updatedState : ParsedBVExprState :=  { currState with
                                                         maxFreeVarId := newId
                                                         , inputVarToBVExpr := currState.inputVarToBVExpr.insert userFacingName newWrappedExpr
                                                         , inputVarIdToDisplayName := currState.inputVarIdToDisplayName.insert newId userFacingName
                                                         }
                set updatedState
                return some newWrappedExpr

  rotateReflection (innerExpr: Expr) (distanceExpr : Expr) (rotateOp: Nat → BVUnOp)
          : ParseBVExprM (Option (BVExprWrapper)) := do
      let some inner ← go innerExpr | return none
      let some distance ← getNatValue? distanceExpr | return none
      return some {bvExpr := GenBVExpr.un (rotateOp distance) inner.bvExpr, width := inner.width}

  binaryReflection (lhsExpr rhsExpr : Expr) (op : BVBinOp) : ParseBVExprM (Option (BVExprWrapper)) := do
    let some lhs ← go lhsExpr | return none
    let some rhs ← go rhsExpr | return none

    if h : lhs.width = rhs.width then
      let rhs' := h ▸ rhs.bvExpr  -- cast rhs to BVExpr lhs.width
      return some {bvExpr := GenBVExpr.bin lhs.bvExpr op rhs', width := lhs.width}
    else
      return none

  shiftReflection (innerExpr : Expr) (distanceExpr : Expr) (shiftOp : {m n : Nat} → GenBVExpr m → GenBVExpr n → GenBVExpr m)
        : ParseBVExprM (Option (BVExprWrapper)) := do
      let some inner ← go innerExpr | return none
      let some distance ← go distanceExpr | return none
      return some {bvExpr :=  shiftOp inner.bvExpr distance.bvExpr, width := inner.width}


  getConstantBVExpr? (nExpr : Expr) (vExpr : Expr) : ParseBVExprM (Option (BVExprWrapper)) := do
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

  processBitVec (pbv : BVExpr.PackedBitVec) : ParseBVExprM (Option BVExprWrapper) := do
    let currState: ParsedBVExprState ← get
    let existingVal :=  currState.valToSymVar[pbv]?
    match existingVal with
    | none =>
      let numSymVars := currState.numSymVars
      let newId := 1001 + numSymVars
      let newExpr : GenBVExpr targetWidth := GenBVExpr.var newId

      let updatedState : ParsedBVExprState := { currState with
                                              numSymVars := numSymVars + 1
                                              , originalWidth := pbv.w
                                              , symVarToVal := currState.symVarToVal.insert newId pbv
                                              , valToSymVar := currState.valToSymVar.insert pbv newId
                                              , symVarToDisplayName := currState.symVarToDisplayName.insert newId (Lean.Name.mkSimple s!"C{numSymVars + 1}")}
      set updatedState
      return some {bvExpr := newExpr, width := targetWidth}
    | some var => let newExpr : GenBVExpr targetWidth := GenBVExpr.var var
                  return some {bvExpr := newExpr, width := targetWidth}


def parseExprs (lhsExpr rhsExpr : Expr) (targetWidth : Nat): ParseBVExprM (Option ParsedBVLogicalExpr) := do
  let some lhsRes ← toBVExpr lhsExpr targetWidth | throwError "Could not extract lhs: {lhsExpr}"

  let state ← get
  let lhs: ParsedBVExpr := {bvExpr := lhsRes.bvExpr, width := lhsRes.width, symVars := state.symVarToVal, inputVars := state.inputVarIdToDisplayName}

  let some rhsRes ← toBVExpr rhsExpr targetWidth | throwError "Could not extract rhs: {rhsExpr}"
  let state ← get

  let rhsInputVars := state.inputVarIdToDisplayName.filter fun k _ => !lhs.inputVars.contains k
  let rhsSymVars := state.symVarToVal.filter fun k _ => !lhs.symVars.contains k

  let rhs: ParsedBVExpr := {bvExpr := rhsRes.bvExpr, width := rhsRes.width, symVars := rhsSymVars, inputVars := rhsInputVars}

  trace[Generalize] m! "lhs width: {lhsRes.width}; rhs width: {rhsRes.width}"
  if h : lhsRes.width = rhsRes.width then
    let rhsExpr := h ▸ rhsRes.bvExpr
    let bvLogicalExpr := BoolExpr.literal (GenBVPred.bin lhsRes.bvExpr BVBinPred.eq rhsExpr)
    trace[Generalize] m! "BVLogicalExpr: {bvLogicalExpr}"

    return some {lhs := lhs, rhs := rhs, state := state, bvLogicalExpr := bvLogicalExpr}

  return none


def mkHShift (name : Name) (w n : Nat) (synthName : Name) (lhs rhs : Expr) : Expr :=
  let bitVecW := mkApp (mkConst ``BitVec) (mkNatLit w)
  let bitVecN := mkApp (mkConst ``BitVec) (mkNatLit n)
  let synthInstance := (mkApp2 (.const synthName []) (mkNatLit w) (mkNatLit n)) -- bitVecW bitVecN bitVecW)
  mkApp6 (.const name [levelZero, levelZero, levelZero]) bitVecW bitVecN bitVecW synthInstance lhs rhs


def bvExprToExpr (parsedBVExpr : ParsedBVLogicalExpr)
  (bvExpr : GenBVExpr w)  : MetaM Expr := do
  -- let parsedBVExprState := (← get).parsedBVLogicalExpr.state
  let parsedBVExprState := parsedBVExpr.state
  let allNames := Std.HashMap.union parsedBVExprState.inputVarIdToDisplayName parsedBVExprState.symVarToDisplayName

  let bitVecWidth := (mkNatLit w)
  match bvExpr with
  | .var idx => let localDecl ← getLocalDeclFromUserName allNames[idx]!
                pure (mkFVar localDecl.fvarId)
  | .const val => mkAppM ``BitVec.ofInt #[bitVecWidth,  (mkIntLit val.toInt)]
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
  | .arithShiftRight lhs rhs => return mkApp4 (.const ``BitVec.sshiftRight' []) bitVecWidth bitVecWidth (← bvExprToExpr parsedBVExpr lhs) (← bvExprToExpr parsedBVExpr rhs)
  | .zeroExtend v expr => return mkApp3  (.const ``BitVec.zeroExtend []) bitVecWidth (mkNatLit v) (← bvExprToExpr parsedBVExpr expr)
  | .truncate v expr => return mkApp3  (.const ``BitVec.truncate []) bitVecWidth (mkNatLit v) (← bvExprToExpr parsedBVExpr expr)
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
        | .beq => return mkApp4 (.const ``BEq.beq [levelZero]) (mkConst ``Bool) (beqBoolInstExpr) (← go lhs) (← go rhs)--mkAppM ``BEq.beq #[← go lhs, ← go rhs]
  | _ => throwError m! "Unsupported operation"

instance : HydrableInstances  ParsedBVLogicalExpr GenBVLogicalExpr GenBVExpr where

instance : HydrableGetAllNamesFromParsedLogicalExpr ParsedBVLogicalExpr GenBVLogicalExpr GenBVExpr where
  getAllNamesFromParsedLogicalExpr p :=
    Std.HashMap.union p.state.inputVarIdToDisplayName p.state.symVarToDisplayName

instance : HydrableGetLogicalExprSize  ParsedBVLogicalExpr GenBVLogicalExpr GenBVExpr where
  getLogicalExprSize e := e.size

instance : HydrableGenLogicalExprToExpr ParsedBVLogicalExpr GenBVLogicalExpr GenBVExpr where
  genLogicalExprToExpr := toExpr

instance : HydrableSolve ParsedBVLogicalExpr GenBVLogicalExpr GenBVExpr where

instance :  HydrableGeneratePreconditions ParsedBVLogicalExpr GenBVLogicalExpr GenBVExpr where
 generatePreconditions := fun a b c d => do
  let v ← solve a
  sorry



set_option trace.Meta.synthInstance true in
/-
instance : Hydrable ParsedBVLogicalExpr GenBVLogicalExpr GenBVExpr where
  genExprToExpr := bvExprToExpr
  genLogicalExprToExpr := toExpr
  getAllNamesFromParsedLogicalExpr p :=
    Std.HashMap.union p.state.inputVarIdToDisplayName p.state.symVarToDisplayName
  getLogicalExprSize e := e.size
  substitute := substitute
  packedBitVecToSubstitutionValue := packedBitVecToSubstitutionValue
  genExprToSubstitutionValue := bvExprToSubstitutionValue
  getIdentityAndAbsorptionConstraints := getIdentityAndAbsorptionConstraints
  addConstraints := addConstraints
  deductiveSearch := deductiveSearch
  not e := BoolExpr.not e
  and e1 e2 := BoolExpr.gate Gate.and e1 e2
  True := BoolExpr.const True
  False := BoolExpr.const False
  genExprVar id := GenBVExpr.var id
  genExprConst bv := GenBVExpr.const bv
  eq e1 e2 := BoolExpr.literal (GenBVPred.bin e1 BVBinPred.eq e2)
  beq e1 e2 := BoolExpr.gate Gate.beq e1 e2
  evalGenExpr := evalBVExpr
  evalGenLogicalExpr := evalBVLogicalExpr
-/

instance : HydrableSubstitute ParsedBVLogicalExpr GenBVLogicalExpr GenBVExpr where
  substitute := substitute

instance : HydrablePackedBitvecToSubstitutionValue ParsedBVLogicalExpr GenBVLogicalExpr GenBVExpr where
  packedBitVecToSubstitutionValue := packedBitVecToSubstitutionValue

instance : HydrableBooleanAlgebra ParsedBVLogicalExpr GenBVLogicalExpr GenBVExpr where
  not e := BoolExpr.not e
  and e1 e2 := BoolExpr.gate Gate.and e1 e2
  True := BoolExpr.const True
  False := BoolExpr.const False
  eq e1 e2 := BoolExpr.literal (GenBVPred.bin e1 BVBinPred.eq e2)
  beq e1 e2 := BoolExpr.gate Gate.beq e1 e2

instance : HydrableGetIdentityAndAbsorptionConstraints ParsedBVLogicalExpr GenBVLogicalExpr GenBVExpr where
  getIdentityAndAbsorptionConstraints := getIdentityAndAbsorptionConstraints

instance : HydrableAddConstraints ParsedBVLogicalExpr GenBVLogicalExpr GenBVExpr where
  addConstraints := addConstraints

instance : HydrableGenExpr ParsedBVLogicalExpr GenBVLogicalExpr GenBVExpr where
  genExprVar id := GenBVExpr.var id
  genExprConst bv := GenBVExpr.const bv

instance : HydrableExistsForall ParsedBVLogicalExpr GenBVLogicalExpr GenBVExpr where


elab "#reducewidth" expr:term " : " target:term : command =>
  open Lean Lean.Elab Command Term in
  withoutModifyingEnv <| runTermElabM fun _ => Term.withDeclName `_reduceWidth do
      let targetExpr ← Term.elabTerm target (some (mkConst ``Nat))
      let some targetWidth ← getNatValue? targetExpr | throwError "Invalid width provided"

      let hExpr ← Term.elabTerm expr none
      trace[Generalize] m! "hexpr: {hExpr}"

      match_expr hExpr with
      | Eq _ lhsExpr rhsExpr =>
           let initialState : ParsedBVExprState := default
           let some (parsedBvExpr) ← (parseExprs lhsExpr rhsExpr targetWidth).run' initialState | throwError "Unsupported expression provided"

           let bvExpr := parsedBvExpr.bvLogicalExpr
           let state := parsedBvExpr.state
           trace[Generalize] m! "bvExpr: {bvExpr}, state: {state}"

           let initialGeneralizerState : GeneralizerState ParsedBVLogicalExpr GenBVLogicalExpr GenBVExpr :=
                { startTime                := 0
                , widthId                  := 0
                , timeout                  := 0
                , processingWidth          := targetWidth
                , targetWidth              := targetWidth
                , parsedBVLogicalExpr       := parsedBvExpr
                , needsPreconditionsExprs   := []
                , visitedSubstitutions      := Std.HashSet.emptyWithCapacity
                , constantExprsEnumerationCache  := Std.HashMap.emptyWithCapacity
                }


           let results ← (existsForAll bvExpr state.symVarToVal.keys state.inputVarIdToDisplayName.keys 3).run' initialGeneralizerState

           logInfo m! "Results: {results}"
      | _ =>
            logInfo m! "Could not match"
      pure ()


variable {x y z : BitVec 64}
--set_option trace.Meta.Tactic.bv true
#reducewidth (x + 0 = x) : 4
#reducewidth ((x <<< 8) >>> 16) <<< 8 = x &&& 0x00ffff00#64 : 4
#reducewidth (x <<< 3  = y + (BitVec.ofNat 64 3)) : 4
#reducewidth (x <<< 3) <<< 4 = x <<< 7 : 4
#reducewidth x + 5 = x : 8
#reducewidth x = 10 : 8
#reducewidth (x + (-21)) >>> 1 = x >>> 1 : 4

variable {x y z : BitVec 32}
#reducewidth (x ||| 145#32) &&& 177#32 ^^^ 153#32 = x &&& 32#32 ||| 8#32  : 8
#reducewidth 1#32 <<< (31#32 - x) = BitVec.ofInt 32 (-2147483648) >>> x : 8
#reducewidth 8#32 - x &&& 7#32 = 0#32 - x &&& 7#32 : 4

#reducewidth BitVec.sshiftRight' (x &&& ((BitVec.ofInt 32 (-1)) <<< (32 - y))) (BitVec.ofInt 32 32 - y) = BitVec.sshiftRight' x (BitVec.ofInt 32 32 - y) : 8
#reducewidth x <<< 6#32 <<< 28#32 = 0#32 : 4



def pruneEquivalentBVExprs (expressions: List (GenBVExpr w)) : GeneralizerStateM ParsedBVLogicalExpr GenBVLogicalExpr GenBVExpr (List (GenBVExpr w)) := do
  withTraceNode `Generalize (fun _ => return "Pruned equivalent bvExprs") do
    let mut pruned : List (GenBVExpr w) := []

    for expr in expressions do
      if pruned.isEmpty then
        pruned := expr :: pruned
        continue

      let newConstraints := pruned.map (fun f =>  BoolExpr.not (BoolExpr.literal (GenBVPred.bin f BVBinPred.eq expr)))
      let subsumeCheckExpr :=  addConstraints (BoolExpr.const True) newConstraints Gate.and

      if let some _ ← solve subsumeCheckExpr then
        pruned := expr :: pruned

    trace[Generalize] m! "Removed {expressions.length - pruned.length} expressions after pruning {expressions.length} expressions"

    pure pruned

def updateConstantValues (bvExpr: ParsedBVExpr) (assignments: Std.HashMap Nat BVExpr.PackedBitVec)
             : ParsedBVExpr := {bvExpr with symVars := assignments.filter (λ id _ => bvExpr.symVars.contains id)}
