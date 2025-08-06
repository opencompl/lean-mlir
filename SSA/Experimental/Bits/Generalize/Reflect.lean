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

def defaultParsedExprState : ParsedInputState BVExprWrapper := { maxFreeVarId := 0 , numSymVars := 0, originalWidth := 32
                                                                , inputVarIdToDisplayName := {}, symVarToVal := {}
                                                                , symVarToDisplayName := {}, inputVarToExprWrapper := {}, valToSymVar:= {}}

def printParsedBVExprState (s: ParsedInputState BVExprWrapper) :=
    s!"ParsedBVExprState:\n" ++
    s!"  maxFreeVarId: {s.maxFreeVarId}\n" ++
    s!"  numSymVars: {s.numSymVars}\n" ++
    s!"  freeVarToBVExpr: {s.inputVarToExprWrapper}\n" ++
    s!"  BVExprIdToFreeVar: {s.inputVarIdToDisplayName}\n" ++
    s!"  symVarToVal: {s.symVarToVal}" ++
    s!"  symVarToDisplayName: {s.symVarToDisplayName}"


instance : ToMessageData (ParsedInputState BVExprWrapper) where
  toMessageData s := printParsedBVExprState s


instance : ToString (ParsedInputState BVExprWrapper) where
  toString s := printParsedBVExprState s


structure ParsedBVExpr where
  width : Nat
  bvExpr: GenBVExpr width
  symVars: Std.HashMap Nat BVExpr.PackedBitVec
  inputVars : Std.HashMap Nat Name

abbrev ParsedBVLogicalExpr := ParsedLogicalExpr BVExprWrapper ParsedBVExpr GenBVLogicalExpr

partial def toBVExpr (expr : Expr) (targetWidth: Nat) : ParseExprM BVExprWrapper (Option (BVExprWrapper)) := do
  go expr
  where

  go (x : Expr) : ParseExprM BVExprWrapper (Option (BVExprWrapper)) := do
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
              let currState: ParsedInputState BVExprWrapper ← get
              let pbv : BVExpr.PackedBitVec := {bv := BitVec.ofNat currState.originalWidth v}
              let existingVal :=  currState.valToSymVar[pbv]?

              match existingVal with
              | none => let numSymVars := currState.numSymVars
                        let newId := 1001 + numSymVars
                        let newExpr : GenBVExpr targetWidth := GenBVExpr.var newId

                        let updatedState : ParsedInputState BVExprWrapper := { currState with
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
            let currState: ParsedInputState BVExprWrapper ← get
            let .fvar name := x | throwError m! "Unknown expression: {x}"
            let userFacingName := ((← getLCtx).get! name).userName

            let existingVar? := currState.inputVarToExprWrapper[userFacingName]?
            match existingVar? with
            | some val => return val
            | none =>
                let newId := currState.maxFreeVarId + 1
                let newExpr : GenBVExpr targetWidth :=  GenBVExpr.var newId
                let newWrappedExpr : BVExprWrapper := {bvExpr := newExpr, width := targetWidth}

                let updatedState : ParsedInputState BVExprWrapper :=  { currState with
                                                         maxFreeVarId := newId
                                                         , inputVarToExprWrapper := currState.inputVarToExprWrapper.insert userFacingName newWrappedExpr
                                                         , inputVarIdToDisplayName := currState.inputVarIdToDisplayName.insert newId userFacingName
                                                         }
                set updatedState
                return some newWrappedExpr

  rotateReflection (innerExpr: Expr) (distanceExpr : Expr) (rotateOp: Nat → BVUnOp)
          : ParseExprM BVExprWrapper (Option (BVExprWrapper)) := do
      let some inner ← go innerExpr | return none
      let some distance ← getNatValue? distanceExpr | return none
      return some {bvExpr := GenBVExpr.un (rotateOp distance) inner.bvExpr, width := inner.width}

  binaryReflection (lhsExpr rhsExpr : Expr) (op : BVBinOp) : ParseExprM BVExprWrapper (Option (BVExprWrapper)) := do
    let some lhs ← go lhsExpr | return none
    let some rhs ← go rhsExpr | return none

    if h : lhs.width = rhs.width then
      let rhs' := h ▸ rhs.bvExpr  -- cast rhs to BVExpr lhs.width
      return some {bvExpr := GenBVExpr.bin lhs.bvExpr op rhs', width := lhs.width}
    else
      return none

  shiftReflection (innerExpr : Expr) (distanceExpr : Expr) (shiftOp : {m n : Nat} → GenBVExpr m → GenBVExpr n → GenBVExpr m)
        : ParseExprM BVExprWrapper (Option (BVExprWrapper)) := do
      let some inner ← go innerExpr | return none
      let some distance ← go distanceExpr | return none
      return some {bvExpr :=  shiftOp inner.bvExpr distance.bvExpr, width := inner.width}


  getConstantBVExpr? (nExpr : Expr) (vExpr : Expr) : ParseExprM BVExprWrapper (Option (BVExprWrapper)) := do
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

  processBitVec (pbv : BVExpr.PackedBitVec) : ParseExprM BVExprWrapper (Option BVExprWrapper) := do
    let currState: ParsedInputState BVExprWrapper  ← get
    let existingVal :=  currState.valToSymVar[pbv]?
    match existingVal with
    | none =>
      let numSymVars := currState.numSymVars
      let newId := 1001 + numSymVars
      let newExpr : GenBVExpr targetWidth := GenBVExpr.var newId

      let updatedState : ParsedInputState BVExprWrapper := { currState with
                                              numSymVars := numSymVars + 1
                                              , originalWidth := pbv.w
                                              , symVarToVal := currState.symVarToVal.insert newId pbv
                                              , valToSymVar := currState.valToSymVar.insert pbv newId
                                              , symVarToDisplayName := currState.symVarToDisplayName.insert newId (Lean.Name.mkSimple s!"C{numSymVars + 1}")}
      set updatedState
      return some {bvExpr := newExpr, width := targetWidth}
    | some var => let newExpr : GenBVExpr targetWidth := GenBVExpr.var var
                  return some {bvExpr := newExpr, width := targetWidth}


def parseExprs (lhsExpr rhsExpr : Expr) (targetWidth : Nat): ParseExprM BVExprWrapper (Option ParsedBVLogicalExpr)  := do
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

    return some {lhs := lhs, rhs := rhs, state := state, logicalExpr := bvLogicalExpr}

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

instance : HydrableInstances GenBVLogicalExpr GenBVExpr where

instance : HydrableGetAllNamesFromParsedLogicalExpr BVExprWrapper ParsedBVExpr GenBVLogicalExpr GenBVExpr where
  getAllNamesFromParsedLogicalExpr p :=
    Std.HashMap.union p.state.inputVarIdToDisplayName p.state.symVarToDisplayName

instance : HydrableGetLogicalExprSize GenBVLogicalExpr where
  getLogicalExprSize e := e.size

instance : HydrableGenLogicalExprToExpr  BVExprWrapper ParsedBVExpr GenBVLogicalExpr GenBVExpr where
  genLogicalExprToExpr := toExpr

instance : HydrableSolve  BVExprWrapper ParsedBVExpr GenBVLogicalExpr GenBVExpr where

instance : HydrableChangeExprWidth GenBVExpr where
  changeExprWidth := changeBVExprWidth

instance : HydrableChangeLogicalExprWidth GenBVLogicalExpr where
  changeLogicalExprWidth := changeBVLogicalExprWidth

instance : HydrableParseExprs GenBVLogicalExpr BVExprWrapper ParsedBVExpr where
  parseExprs := parseExprs
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

instance : HydrableSubstitute GenBVLogicalExpr GenBVExpr where
  substitute := substitute

instance : HydrablePackedBitvecToSubstitutionValue GenBVLogicalExpr GenBVExpr where
  packedBitVecToSubstitutionValue := packedBitVecToSubstitutionValue

instance : HydrableBooleanAlgebra GenBVLogicalExpr GenBVExpr where
  not e := BoolExpr.not e
  and e1 e2 := BoolExpr.gate Gate.and e1 e2
  True := BoolExpr.const True
  False := BoolExpr.const False
  eq e1 e2 := BoolExpr.literal (GenBVPred.bin e1 BVBinPred.eq e2)
  beq e1 e2 := BoolExpr.gate Gate.beq e1 e2

instance : HydrableGetIdentityAndAbsorptionConstraints GenBVLogicalExpr GenBVExpr where
  getIdentityAndAbsorptionConstraints := getIdentityAndAbsorptionConstraints

instance : HydrableAddConstraints GenBVLogicalExpr GenBVExpr where
  addConstraints := addConstraints

instance : HydrableGenExpr GenBVLogicalExpr GenBVExpr where
  genExprVar id := GenBVExpr.var id
  genExprConst bv := GenBVExpr.const bv

instance : HydrableExistsForall  BVExprWrapper ParsedBVExpr GenBVLogicalExpr GenBVExpr where

instance : HydrableInitialParserState BVExprWrapper where
  initialParserState := defaultParsedExprState

elab "#reducewidth" expr:term " : " target:term : command =>
  open Lean Lean.Elab Command Term in
  withoutModifyingEnv <| runTermElabM fun _ => Term.withDeclName `_reduceWidth do
      let targetExpr ← Term.elabTerm target (some (mkConst ``Nat))
      let some targetWidth ← getNatValue? targetExpr | throwError "Invalid width provided"

      let hExpr ← Term.elabTerm expr none
      trace[Generalize] m! "hexpr: {hExpr}"

      match_expr hExpr with
      | Eq _ lhsExpr rhsExpr =>
           let initialState  := defaultParsedExprState
           let some (parsedBvExpr) ← (parseExprs lhsExpr rhsExpr targetWidth).run' initialState | throwError "Unsupported expression provided"

           let bvExpr := parsedBvExpr.logicalExpr
           let state := parsedBvExpr.state
           trace[Generalize] m! "bvExpr: {bvExpr}, state: {state}"

           let initialGeneralizerState : GeneralizerState  BVExprWrapper ParsedBVExpr GenBVLogicalExpr GenBVExpr :=
                { startTime                := 0
                , widthId                  := 0
                , timeout                  := 0
                , processingWidth          := targetWidth
                , targetWidth              := targetWidth
                , parsedLogicalExpr       := parsedBvExpr
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


def pruneEquivalentBVExprs (expressions: List (GenBVExpr w)) : GeneralizerStateM  BVExprWrapper ParsedBVExpr GenBVLogicalExpr GenBVExpr (List (GenBVExpr w)) := do
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

def pruneEquivalentBVLogicalExprs(expressions : List GenBVLogicalExpr): GeneralizerStateM BVExprWrapper ParsedBVExpr GenBVLogicalExpr GenBVExpr (List GenBVLogicalExpr) := do
  withTraceNode `Generalize (fun _ => return "Pruned equivalent bvLogicalExprs") do
    let mut pruned: List GenBVLogicalExpr:= []
    for expr in expressions do
      if pruned.isEmpty then
        pruned := expr :: pruned
        continue

      let newConstraints := pruned.map (fun f =>  BoolExpr.not (BoolExpr.gate Gate.beq f expr))
      let subsumeCheckExpr :=  addConstraints (BoolExpr.const True) newConstraints Gate.and

      if let some _ ← solve subsumeCheckExpr then
        pruned := expr :: pruned

    logInfo m! "Removed {expressions.length - pruned.length} expressions after pruning"
    pure pruned

def updateConstantValues (bvExpr: ParsedBVExpr) (assignments: Std.HashMap Nat BVExpr.PackedBitVec)
             : ParsedBVExpr := {bvExpr with symVars := assignments.filter (λ id _ => bvExpr.symVars.contains id)}

def filterCandidatePredicates  (bvLogicalExpr: GenBVLogicalExpr) (preconditionCandidates visited: Std.HashSet GenBVLogicalExpr)
                                                    : GeneralizerStateM BVExprWrapper ParsedBVExpr GenBVLogicalExpr GenBVExpr (List GenBVLogicalExpr) :=
  withTraceNode `Generalize (fun _ => return "Filtered out invalid expression sketches") do
    let state ← get
    let widthId := state.widthId
    let bitwidth := state.processingWidth

    let mut res : List GenBVLogicalExpr := []
    -- let mut currentCandidates := preconditionCandidates
    -- if numConjunctions >= 1 then
    --   let combinations := generateCombinations numConjunctions currentCandidates.toList
    --   currentCandidates := Std.HashSet.ofList (combinations.map (λ comb => addConstraints (BoolExpr.const True) comb))
    let widthConstraint : GenBVLogicalExpr := BoolExpr.literal (GenBVPred.bin (GenBVExpr.var widthId) BVBinPred.eq (GenBVExpr.const (BitVec.ofNat bitwidth bitwidth)))

    let mut numInvocations := 0
    let mut currentCandidates := preconditionCandidates.filter (λ cand => !visited.contains cand)
    logInfo m! "Originally processing {currentCandidates.size} candidates"

    -- Progressive filtering implementation
    while !currentCandidates.isEmpty do
      let expressionsConstraints : GenBVLogicalExpr := addConstraints (BoolExpr.const False) currentCandidates.toList Gate.or
      let expr := BoolExpr.gate Gate.and (addConstraints expressionsConstraints [widthConstraint] Gate.and) (BoolExpr.not bvLogicalExpr)

      let mut newCandidates : Std.HashSet GenBVLogicalExpr := Std.HashSet.emptyWithCapacity
      numInvocations := numInvocations + 1
      match (← solve expr) with
      | none => break
      | some assignment =>
          newCandidates ← withTraceNode `Generalize (fun _ => return "Evaluated expressions for filtering") do
            let mut res : Std.HashSet GenBVLogicalExpr := Std.HashSet.emptyWithCapacity
            for candidate in currentCandidates do
              let widthSubstitutedCandidate := substitute candidate (bvExprToSubstitutionValue (Std.HashMap.ofList [(widthId, GenBVExpr.const (BitVec.ofNat bitwidth bitwidth))]))
              if !(evalBVLogicalExpr assignment bitwidth widthSubstitutedCandidate) then
                res := res.insert candidate
            pure res

      currentCandidates := newCandidates

    logInfo m! "Invoked the solver {numInvocations} times for {preconditionCandidates.size} potential candidates."
    res := currentCandidates.toList
    pure res


def getPreconditionSynthesisComponents (positiveExamples negativeExamples: List (Std.HashMap Nat BVExpr.PackedBitVec)) (specialConstants : Std.HashMap (GenBVExpr w) BVExpr.PackedBitVec) :
                  Std.HashMap (GenBVExpr w)  PreconditionSynthesisCacheValue := Id.run do
    let groupExamplesBySymVar (examples : List (Std.HashMap Nat BVExpr.PackedBitVec)) : Std.HashMap (GenBVExpr w) (List BVExpr.PackedBitVec) := Id.run do
      let mut res : Std.HashMap (GenBVExpr w) (List BVExpr.PackedBitVec) := Std.HashMap.emptyWithCapacity
      for ex in examples do
        for (const, val) in ex.toArray do
          let constVar : GenBVExpr w := GenBVExpr.var const
          let existingList := res.getD constVar []
          res := res.insert constVar (val::existingList)
      res

    let positiveExamplesByKey := groupExamplesBySymVar positiveExamples
    let negativeExamplesByKey := groupExamplesBySymVar negativeExamples

    let mut allInputs : Std.HashMap (GenBVExpr w)  PreconditionSynthesisCacheValue := Std.HashMap.emptyWithCapacity
    for key in positiveExamplesByKey.keys do
      allInputs := allInputs.insert key {positiveExampleValues := positiveExamplesByKey[key]!, negativeExampleValues := negativeExamplesByKey[key]!}

    for (sc, val) in specialConstants.toArray do
      allInputs := allInputs.insert sc {positiveExampleValues := List.replicate positiveExamples.length val, negativeExampleValues := List.replicate negativeExamples.length val}

    return allInputs


def precondSynthesisUpdateCache (previousLevelCache synthesisComponents: Std.HashMap (GenBVExpr w)  PreconditionSynthesisCacheValue)
    (positiveExamples negativeExamples: List (Std.HashMap Nat BVExpr.PackedBitVec)) (specialConstants : Std.HashMap (GenBVExpr w) BVExpr.PackedBitVec)
    (ops : List (GenBVExpr w → GenBVExpr w → GenBVExpr w)) : GeneralizerStateM BVExprWrapper ParsedBVExpr GenBVLogicalExpr GenBVExpr (Std.HashMap (GenBVExpr w) PreconditionSynthesisCacheValue) := do
    let mut currentCache := Std.HashMap.emptyWithCapacity
    let mut observationalEquivFilter : Std.HashSet String := Std.HashSet.emptyWithCapacity

    let evaluateCombinations (combos :  List (BVExpr.PackedBitVec × BVExpr.PackedBitVec)) (examples: List (Std.HashMap Nat BVExpr.PackedBitVec))
            (op : GenBVExpr w → GenBVExpr w → GenBVExpr w) : GeneralizerStateM BVExprWrapper ParsedBVExpr GenBVLogicalExpr GenBVExpr (List (BitVec w)) := do
          let mut res : List (BitVec w) := []
          let mut index := 0
          for (lhs, rhs) in combos do
            let h : lhs.w = w := sorry
            let h' : rhs.w = w := sorry
            if h : lhs.w = w ∧ rhs.w = w then
              res := (evalBVExpr examples[index]! w (op  (GenBVExpr.const (h.left ▸ lhs.bv)) (GenBVExpr.const (h.right ▸ rhs.bv)))) :: res
              index := index + 1
            else
              throwError m! "Invalid width for lhs:{lhs} and rhs:{rhs}"
          pure res

    for (bvExpr, intermediateRes) in previousLevelCache.toArray do
      let intermediateNegValues := intermediateRes.negativeExampleValues
      let intermediatePosValues := intermediateRes.positiveExampleValues

      for op in ops do
        for (var, componentValue) in synthesisComponents.toArray do
          if specialConstants.contains bvExpr && specialConstants.contains var then --
            continue

          -- Combine the previous cache values with the synthesis components
          let negExCombinations := List.zip intermediateNegValues componentValue.negativeExampleValues
          let evaluatedNegativeExs ← evaluateCombinations negExCombinations negativeExamples op

          let posExCombinations := List.zip intermediatePosValues componentValue.positiveExampleValues
          let evaluatedPositiveExs  ← evaluateCombinations posExCombinations positiveExamples op

          let filterCheckStr := toString (evaluatedNegativeExs ++ evaluatedPositiveExs)
          if observationalEquivFilter.contains filterCheckStr then
            continue

          let newExpr := op bvExpr var
          currentCache := currentCache.insert newExpr { negativeExampleValues := evaluatedNegativeExs.map (λ ex => {bv := ex, w := w})
                                                      , positiveExampleValues := evaluatedPositiveExs.map (λ ex => {bv := ex, w := w}) : PreconditionSynthesisCacheValue}
          observationalEquivFilter := observationalEquivFilter.insert filterCheckStr

    return currentCache

instance :  HydrableCheckTimeout BVExprWrapper ParsedBVExpr GenBVLogicalExpr GenBVExpr where

def generatePreconditions (bvLogicalExpr: GenBVLogicalExpr) (positiveExamples negativeExamples: List (Std.HashMap Nat BVExpr.PackedBitVec))
              (_numConjunctions: Nat) : GeneralizerStateM BVExprWrapper ParsedBVExpr GenBVLogicalExpr GenBVExpr (Option GenBVLogicalExpr) := do

    let state ← get
    let widthId := state.widthId
    let bitwidth := state.processingWidth

    let specialConstants : Std.HashMap (GenBVExpr bitwidth) BVExpr.PackedBitVec := Std.HashMap.ofList [
        ((one bitwidth), {bv := BitVec.ofNat bitwidth 1}),
        ((minusOne bitwidth), {bv := BitVec.ofInt bitwidth (-1)}),
        (GenBVExpr.var widthId, {bv := BitVec.ofNat bitwidth bitwidth})]

    let validCandidates ← withTraceNode `Generalize (fun _ => return "Attempted to generate valid preconditions") do
      let mut preconditionCandidates : Std.HashSet GenBVLogicalExpr := Std.HashSet.emptyWithCapacity
      let synthesisComponents : Std.HashMap (GenBVExpr bitwidth)  PreconditionSynthesisCacheValue := getPreconditionSynthesisComponents positiveExamples negativeExamples specialConstants

      -- Check for power of 2: const & (const - 1) == 0
      for const in positiveExamples[0]!.keys do
        let bvExprVar := GenBVExpr.var const
        let powerOf2Expr :=  GenBVExpr.bin bvExprVar BVBinOp.and (GenBVExpr.bin bvExprVar BVBinOp.add (minusOne bitwidth))
        let powerOfTwoResults := positiveExamples.map (λ pos => evalBVExpr pos bitwidth powerOf2Expr)

        if powerOfTwoResults.any (λ val => val == 0) then
          let powerOf2 := BoolExpr.literal (GenBVPred.bin powerOf2Expr BVBinPred.eq (zero bitwidth))
          preconditionCandidates := preconditionCandidates.insert powerOf2

      let mut previousLevelCache : Std.HashMap (GenBVExpr bitwidth) PreconditionSynthesisCacheValue := synthesisComponents

      let numVariables := positiveExamples[0]!.keys.length + 1 -- Add 1 for the width ID
      let ops : List (GenBVExpr bitwidth -> GenBVExpr bitwidth -> GenBVExpr bitwidth):= [add, subtract, multiply, and, or, xor, shiftLeft, shiftRight, arithShiftRight]

      let mut currentLevel := 0
      let mut validCandidates : List GenBVLogicalExpr := []
      let mut visited : Std.HashSet GenBVLogicalExpr := Std.HashSet.emptyWithCapacity

      while currentLevel < numVariables do
          logInfo m! "Precondition Synthesis: Processing level {currentLevel}"

          let origCandidatesSize := preconditionCandidates.size
          for (bvExpr, intermediateRes) in previousLevelCache.toArray do
            let evaluatedNegativeExs := intermediateRes.negativeExampleValues.map (λ ex => ex.bv.toInt)
            let evaluatedPositiveExs := intermediateRes.positiveExampleValues.map (λ ex => ex.bv.toInt)

            if (evaluatedPositiveExs.all ( λ val => val == 0)) && evaluatedNegativeExs.all (λ val => val != 0) then
              preconditionCandidates := preconditionCandidates.insert (eqToZero bvExpr)
              continue

            if (evaluatedPositiveExs.any ( λ val => val < 0 || val == 0)) && evaluatedNegativeExs.all (λ val => val > 0) then
              let mut cand := lteZero bvExpr widthId
              if (evaluatedPositiveExs.all ( λ val => val < 0)) then
                cand := strictlyLTZero bvExpr widthId

              preconditionCandidates := preconditionCandidates.insert cand

            if (evaluatedPositiveExs.any ( λ val => val > 0 || val == 0)) && evaluatedNegativeExs.all (λ val => val < 0) then
              let mut cand := gteZero bvExpr widthId
              if (evaluatedPositiveExs.all ( λ val => val > 0)) then
                  cand := strictlyGTZero bvExpr widthId

              preconditionCandidates := preconditionCandidates.insert cand

          -- Check if we have a valid candidate
          if preconditionCandidates.size > origCandidatesSize then
            validCandidates ← filterCandidatePredicates bvLogicalExpr preconditionCandidates visited
            match validCandidates with
            | [] => visited := preconditionCandidates
            | _ => return validCandidates

          checkTimeout

          previousLevelCache ← precondSynthesisUpdateCache previousLevelCache synthesisComponents positiveExamples negativeExamples specialConstants ops
          currentLevel := currentLevel + 1

      pure validCandidates

    if validCandidates.isEmpty then
      return none

    if validCandidates.length == 1 then
      return validCandidates[0]?

    -- Prune expressions
    let prunedResults ← pruneEquivalentBVLogicalExprs validCandidates
    match prunedResults with
    | [] => return none
    | _ =>  return some (addConstraints (BoolExpr.const false) prunedResults Gate.or)


instance :  HydrableGeneratePreconditions BVExprWrapper ParsedBVExpr GenBVLogicalExpr GenBVExpr where
 generatePreconditions := generatePreconditions


def lhsSketchEnumeration  (lhsSketch: GenBVExpr w) (inputVars: List Nat) (lhsSymVars rhsSymVars : Std.HashMap Nat BVExpr.PackedBitVec) : Std.HashMap Nat (List (GenBVExpr w)) := Id.run do
  let zero := GenBVExpr.const (BitVec.ofNat w 0)
  let one := GenBVExpr.const (BitVec.ofNat w 1 )
  let minusOne := GenBVExpr.const (BitVec.ofInt w (-1))

  let specialConstants := [zero, one, minusOne]
  let inputCombinations := productsList (List.replicate inputVars.length specialConstants)

  let lhsSymVarsAsBVExprs : List (GenBVExpr w):= lhsSymVars.keys.map (λ k => GenBVExpr.var k)
  let lhsSymVarsPermutation := productsList (List.replicate lhsSymVarsAsBVExprs.length lhsSymVarsAsBVExprs)

  let inputsAndSymVars := List.product inputCombinations lhsSymVarsPermutation

  let mut rhsVarByValue : Std.HashMap (BitVec w) Nat := Std.HashMap.emptyWithCapacity
  for (var, value) in rhsSymVars.toArray do
    let h : value.w = w := sorry
    rhsVarByValue := rhsVarByValue.insert (h ▸ value.bv) var

  let mut res : Std.HashMap Nat (List (GenBVExpr w)):= Std.HashMap.emptyWithCapacity
  for combo in inputsAndSymVars do
    let inputsSubstitutions := bvExprToSubstitutionValue (Std.HashMap.ofList (List.zip inputVars combo.fst))
    let symVarsSubstitutions := bvExprToSubstitutionValue (Std.HashMap.ofList (List.zip lhsSymVars.keys combo.snd))

    let substitutedExpr := substituteBVExpr lhsSketch (Std.HashMap.union inputsSubstitutions symVarsSubstitutions)
    let evalRes : BitVec w := evalBVExpr lhsSymVars w substitutedExpr

    if rhsVarByValue.contains evalRes then
      let existingVar := rhsVarByValue[evalRes]!
      let existingVarRes := res.getD existingVar []

      res := res.insert existingVar (substitutedExpr::existingVarRes)

  pure res

def pruneConstantExprsSynthesisResults(exprSynthesisResults : Std.HashMap Nat (List (GenBVExpr w)))
                            : GeneralizerStateM  BVExprWrapper ParsedBVExpr GenBVLogicalExpr GenBVExpr (Std.HashMap Nat (List (GenBVExpr w))) := do
      withTraceNode `Generalize (fun _ => return "Pruned expressions synthesis results") do
          let mut tempResults : Std.HashMap Nat (List (GenBVExpr w)) := Std.HashMap.emptyWithCapacity

          for (var, expressions) in exprSynthesisResults.toList do
              let mut prunedExprs ← pruneEquivalentBVExprs expressions
              tempResults := tempResults.insert var prunedExprs.reverse

          pure tempResults

instance :  HydrableGetNegativeExamples  BVExprWrapper ParsedBVExpr GenBVLogicalExpr GenBVExpr where

def getCombinationWithNoPreconditions (exprSynthesisResults : Std.HashMap Nat (List (GenBVExpr processingWidth)))
                                            : GeneralizerStateM  BVExprWrapper ParsedBVExpr GenBVLogicalExpr GenBVExpr (Option GenBVLogicalExpr) := do
  withTraceNode `Generalize (fun _ => return "Checked if expressions require preconditions") do
    -- logInfo m! "Expression synthesis results : {exprSynthesisResults}"
    let combinations := productsList exprSynthesisResults.values
    let mut substitutions := []

    let state ← get
    let parsedBVLogicalExpr := state.parsedLogicalExpr
    let mut visited := state.visitedSubstitutions

    for combo in combinations do
      -- Substitute the generated expressions into the main one, so the constants on the RHS are expressed in terms of the left.
      let zippedCombo := Std.HashMap.ofList (List.zip parsedBVLogicalExpr.rhs.symVars.keys combo)
      let substitution := substitute parsedBVLogicalExpr.logicalExpr (bvExprToSubstitutionValue zippedCombo)
      if !visited.contains substitution && !(sameBothSides substitution) then
        substitutions := substitution :: substitutions
        visited := visited.insert substitution

    let mut needsPreconditionExprs := state.needsPreconditionsExprs
    for subst in substitutions.reverse do -- We reverse in a few places so we can process in roughly increasing cost
      let negativeExample ← getNegativeExamples subst parsedBVLogicalExpr.lhs.symVars.keys 1
      if negativeExample.isEmpty then
        return some subst
      needsPreconditionExprs := subst :: needsPreconditionExprs

    let updatedState := {state with visitedSubstitutions := visited, needsPreconditionsExprs := needsPreconditionExprs}
    set updatedState

    return none

def constantExprsEnumerationFromCache (allLhsVars : Std.HashMap (GenBVExpr w) BVExpr.PackedBitVec ) (lhsSymVars rhsSymVars : Std.HashMap Nat BVExpr.PackedBitVec)
                                          (ops: List (GenBVExpr w → GenBVExpr w → GenBVExpr w))
                                          : GeneralizerStateM  BVExprWrapper ParsedBVExpr GenBVLogicalExpr GenBVExpr (Std.HashMap Nat (List (GenBVExpr w))) := do
    let zero := BitVec.ofNat w 0
    let one := BitVec.ofNat w 1
    let minusOne := BitVec.ofInt w (-1)

    let specialConstants : Std.HashMap (GenBVExpr w) BVExpr.PackedBitVec := Std.HashMap.ofList [
      (GenBVExpr.const one, {bv := one}),
      (GenBVExpr.const minusOne, {bv := minusOne})
    ]

    let mut rhsVarByValue : Std.HashMap (BitVec w) Nat := Std.HashMap.emptyWithCapacity
    for (var, value) in rhsSymVars.toArray do
      let h : value.w = w := sorry
      rhsVarByValue := rhsVarByValue.insert (h ▸ value.bv) var


    let state ← get
    let h : state.processingWidth = w := sorry
    let mut previousLevelCache := state.constantExprsEnumerationCache

    if previousLevelCache.isEmpty then
      previousLevelCache := h ▸ allLhsVars

    let mut currentCache := Std.HashMap.emptyWithCapacity

    let mut res : Std.HashMap Nat (List (GenBVExpr w)):= Std.HashMap.emptyWithCapacity
    for (bvExpr, packedBV) in previousLevelCache.toArray do
      let h' : packedBV.w = w := sorry

      let packedBVExpr : GenBVExpr w := GenBVExpr.const (h' ▸ packedBV.bv)

      for (lhsVar, lhsVal) in allLhsVars.toArray do
        for op in ops do
          let evaluatedRes := evalBVExpr lhsSymVars w (op packedBVExpr lhsVar)

          let mut newExpr : GenBVExpr w := op (h ▸ bvExpr) lhsVar
          let rhsVarForValue := rhsVarByValue[evaluatedRes]?

          match rhsVarForValue with
          | some rhsVar =>
              let existingCandidates := res.getD rhsVar []
              res := res.insert rhsVar (newExpr::existingCandidates)
          | none =>
            if evaluatedRes == h' ▸ packedBV.bv then
              newExpr := h ▸ bvExpr
            currentCache := currentCache.insert newExpr {bv := evaluatedRes : BVExpr.PackedBitVec}

    set {state with constantExprsEnumerationCache := h ▸ currentCache}
    pure res


def synthesizeWithNoPrecondition (constantAssignments : List (Std.HashMap Nat BVExpr.PackedBitVec))
              : GeneralizerStateM BVExprWrapper ParsedBVExpr GenBVLogicalExpr GenBVExpr (Option GenBVLogicalExpr) :=  do
    let state ← get
    let parsedBVLogicalExpr := state.parsedLogicalExpr
    let processingWidth := state.processingWidth

    let mut exprSynthesisResults : Std.HashMap Nat (List (GenBVExpr processingWidth)) := Std.HashMap.emptyWithCapacity

    for constantAssignment in constantAssignments do
        logInfo m! "Processing constants assignment: {constantAssignment}"
        let lhs := updateConstantValues parsedBVLogicalExpr.lhs constantAssignment
        let rhs := updateConstantValues parsedBVLogicalExpr.rhs constantAssignment
        let h : lhs.width = processingWidth := sorry

        let lhsAssignments := constantAssignment.filter (fun k _ => lhs.symVars.contains k)
        let rhsAssignments := constantAssignment.filter (fun k _ => rhs.symVars.contains k)

        logInfo m! "Performing deductive search"
        for (targetId, targetVal) in rhsAssignments do
          let deductiveSearchRes ← deductiveSearch lhs.bvExpr lhsAssignments targetVal 3 1234
          match deductiveSearchRes with
          | [] => break
          | x::xs => exprSynthesisResults := exprSynthesisResults.insert targetId (h ▸ deductiveSearchRes)

        if exprSynthesisResults.size == rhsAssignments.size then
          exprSynthesisResults ← pruneConstantExprsSynthesisResults exprSynthesisResults
          match (← getCombinationWithNoPreconditions exprSynthesisResults) with
          | some expr => return (some expr)
          | none => logInfo m! "Could not find a generalized form from just deductive search"

        logInfo m! "Performing enumerative search using a sketch of the LHS"
        let lhsSketchResults := lhsSketchEnumeration lhs.bvExpr lhs.inputVars.keys lhsAssignments rhsAssignments
        for (var, exprs) in lhsSketchResults.toArray do
          let existingExprs := exprSynthesisResults.getD var []
          exprSynthesisResults := exprSynthesisResults.insert var (existingExprs ++ (h ▸ exprs))

        if !lhsSketchResults.isEmpty && exprSynthesisResults.size == rhsAssignments.size then
          exprSynthesisResults ← pruneConstantExprsSynthesisResults exprSynthesisResults
          let preconditionCheckResults ← getCombinationWithNoPreconditions exprSynthesisResults
          match preconditionCheckResults with
          | some expr => return (some expr)
          | none => logInfo m! "Could not find a generalized form from a sketch of the LHS"

        logInfo m! "Performing bottom-up enumerative search one level at a time"

        let specialConstants : Std.HashMap (GenBVExpr state.processingWidth) BVExpr.PackedBitVec := Std.HashMap.ofList [
          ((one processingWidth), {bv := BitVec.ofNat processingWidth 1}),
          ((minusOne processingWidth), {bv :=  BitVec.ofInt processingWidth (-1)})
        ]

        let mut allLHSVars := specialConstants
        for (var, value) in lhsAssignments.toArray do
          allLHSVars := allLHSVars.insert (GenBVExpr.var var) value
          allLHSVars := allLHSVars.insert (GenBVExpr.un BVUnOp.not ((GenBVExpr.var var))) {bv := BitVec.not (value.bv)}

        let ops := [add, subtract, multiply, and, or, xor, shiftLeft, shiftRight, arithShiftRight]

        let mut currentLevel := 1
        while currentLevel < lhs.symVars.size do
          logInfo m! "Expression Synthesis Processing level {currentLevel}"

          let bottomUpRes ← constantExprsEnumerationFromCache allLHSVars lhsAssignments rhsAssignments ops
          for (var, exprs) in bottomUpRes.toArray do
            let existingExprs := exprSynthesisResults.getD var []
            exprSynthesisResults := exprSynthesisResults.insert var (existingExprs ++ exprs)

          if !bottomUpRes.isEmpty && exprSynthesisResults.size == rhsAssignments.size then
            exprSynthesisResults ← pruneConstantExprsSynthesisResults exprSynthesisResults
            let preconditionCheckResults ← getCombinationWithNoPreconditions exprSynthesisResults
            match preconditionCheckResults with
            | some expr => return some expr
            | none => logInfo m! "Could not find a generalized form from processing level {currentLevel}"

          checkTimeout
          currentLevel :=  currentLevel + 1

    return none

instance :  HydrableSynthesizeWithNoPrecondition BVExprWrapper ParsedBVExpr GenBVLogicalExpr GenBVExpr where
 synthesizeWithNoPrecondition := synthesizeWithNoPrecondition

def checkForPreconditions (constantAssignments : List (Std.HashMap Nat BVExpr.PackedBitVec)) (maxConjunctions: Nat)
                                                : GeneralizerStateM BVExprWrapper ParsedBVExpr GenBVLogicalExpr GenBVExpr (Option GenBVLogicalExpr) := do
  let state ← get
  let parsedBVLogicalExpr := state.parsedLogicalExpr

  let positiveExamples := constantAssignments.map (fun assignment => assignment.filter (fun key _ => parsedBVLogicalExpr.lhs.symVars.contains key))

  for numConjunctions in (List.range (maxConjunctions + 1)) do
    logInfo m! "Running with {numConjunctions} allowed conjunctions"
    for expr in state.needsPreconditionsExprs.reverse do
        let negativeExamples ← getNegativeExamples expr positiveExamples[0]!.keys 3
        logInfo m! "Negative examples for {expr} : {negativeExamples}"

        let precondition ← withTraceNode `Generalize (fun _ => return m! "Attempted to generate weak precondition for {expr}") do
                      generatePreconditions expr positiveExamples negativeExamples numConjunctions

        match precondition with
        | none => logInfo m! "Could not generate precondition for expr: {expr} with negative examples: {negativeExamples}"
        | some weakPC =>
                return BoolExpr.ite weakPC expr (BoolExpr.const False)

        checkTimeout
  return none


instance :  HydrableCheckForPreconditions BVExprWrapper ParsedBVExpr GenBVLogicalExpr GenBVExpr where
 checkForPreconditions := checkForPreconditions

def prettifyBVBinOp (op: BVBinOp) : String :=
  match op with
  | .and => "&&&"
  | .or => "|||"
  | .xor => "^^^"
  | _ => op.toString

def prettifyBVBinPred (op : BVBinPred) : String :=
  match op with
  | .eq => "="
  | _ => op.toString

def prettifyBVExpr (bvExpr : GenBVExpr w) (displayNames: Std.HashMap Nat Name) : String :=
    match bvExpr with
    | .var idx => displayNames[idx]!.toString
    | .const bv =>
       toString bv.toInt
    | .bin lhs BVBinOp.add (.bin  (GenBVExpr.const bv) BVBinOp.add (GenBVExpr.un BVUnOp.not rhs)) =>
      if bv.toInt == 1 then -- A subtraction
        s! "({prettifyBVExpr lhs displayNames} - {prettifyBVExpr rhs displayNames})"
      else
        s! "({prettifyBVExpr lhs displayNames} + ({prettifyBVExpr (GenBVExpr.const bv) displayNames} + {prettifyBVExpr (GenBVExpr.un BVUnOp.not rhs) displayNames}))"
    | .bin lhs op rhs =>
       s! "({prettifyBVExpr lhs displayNames} {prettifyBVBinOp op} {prettifyBVExpr rhs displayNames})"
    | .un op operand =>
       s! "({op.toString} {prettifyBVExpr operand displayNames})"
    | .shiftLeft lhs rhs =>
        s! "({prettifyBVExpr lhs displayNames} <<< {prettifyBVExpr rhs displayNames})"
    | .shiftRight lhs rhs =>
        s! "({prettifyBVExpr lhs displayNames} >>> {prettifyBVExpr rhs displayNames})"
    | .arithShiftRight lhs rhs =>
        s! "({prettifyBVExpr lhs displayNames} >>>a {prettifyBVExpr rhs displayNames})"
    | _ => bvExpr.toString

def isGteZeroCheck (expr : GenBVLogicalExpr) : Bool :=
  match expr with
  | .literal (GenBVPred.bin _ BVBinPred.ult (GenBVExpr.shiftLeft (GenBVExpr.const bv) (GenBVExpr.bin (GenBVExpr.var _) BVBinOp.add (GenBVExpr.bin (GenBVExpr.const bv') BVBinOp.add (GenBVExpr.un BVUnOp.not (GenBVExpr.const bv'')))))) =>
          bv.toInt == 1 && bv'.toInt == 1 && bv''.toInt == 1
  | _ => false

def prettifyComparison (bvLogicalExpr : GenBVLogicalExpr) (displayNames: Std.HashMap Nat Name)  : Option String := Id.run do
  let mut res : Option String := none
  match bvLogicalExpr with
  | .literal (GenBVPred.bin lhs BVBinPred.ult _) =>
    if isGteZeroCheck bvLogicalExpr then
      res := some s! "{prettifyBVExpr lhs displayNames} >= 0"
  | .gate Gate.and (BoolExpr.literal (GenBVPred.bin (GenBVExpr.const bv) BVBinPred.ult expr)) rhs =>
    if bv.toInt == 0 && isGteZeroCheck rhs then
      res := some s! "{prettifyBVExpr expr displayNames} > 0"
  | .not expr  =>
     if isGteZeroCheck expr then
      match expr with
      |  .literal (GenBVPred.bin lhs _ _) => res := some s! "{prettifyBVExpr lhs displayNames} < 0"
      | _ => return none
  | _ => return none

  res


def prettify (generalization: GenBVLogicalExpr) (displayNames: Std.HashMap Nat Name) : String :=
  match (prettifyComparison generalization displayNames) with
  | some s => s
  | none =>
      match generalization with
      | .literal (GenBVPred.bin lhs op rhs) =>
          s! "{prettifyBVExpr lhs displayNames} {prettifyBVBinPred op} {prettifyBVExpr rhs displayNames}"
      | .not boolExpr =>
          s! "!({prettify boolExpr displayNames})"
      | .gate op lhs rhs =>
          s! "({prettify lhs displayNames}) {op.toString} ({prettify rhs displayNames})"
      | .ite cond positive _ =>
          s! "if {prettify cond displayNames} then {prettify positive displayNames} "
      | _ => generalization.toString


instance : HydrablePrettify GenBVLogicalExpr where
  prettify := prettify

def prettifyAsTheorem (name: Name) (generalization: GenBVLogicalExpr) (displayNames: Std.HashMap Nat Name) : String := Id.run do
  let params := displayNames.values.filter (λ n => n.toString != "w")

  let mut res := s! "theorem {name}" ++ " {w} " ++ s! "({String.intercalate " " (params.map (λ p => p.toString))} : BitVec w)"

  match generalization with
  | .ite cond positive _ => res := res ++ s! " (h: {prettify cond displayNames}) : {prettify positive displayNames}"
  | _ => res := res ++ s! " : {prettify generalization displayNames}"

  res := res ++ s! " := by sorry"
  pure res

instance : HydrablePrettifyAsTheorem GenBVLogicalExpr where
  prettifyAsTheorem := prettifyAsTheorem
