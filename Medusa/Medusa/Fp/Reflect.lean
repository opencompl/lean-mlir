import Lean.Elab.Term
import Lean

import Medusa.Generalize
import Medusa.Fp.Basic

namespace Generalize

namespace Fp

open Lean
open Lean.Meta
open Std.Sat
open Std.Tactic.BVDecide
open Tactic

-- TODO: where should this live? Why does this not live in Hydra?
def defaultParsedExprState : ParsedInputState :=
  { maxFreeVarId := 0
  , numSymVars := 0, originalWidth := 32
  , inputVarIdToVariable := {}, symVarToVal := {}
  , symVarIdToVariable := {}, displayNameToVariable := {}, valToSymVar:= {}}

-- TODO: this should live in Hydra.
def printParsedFpExprState (s: ParsedInputState) :=
    s!"ParsedFpExprState:\n" ++
    s!"  maxFreeVarId: {s.maxFreeVarId}\n" ++
    s!"  numSymVars: {s.numSymVars}\n" ++
    s!"  displayNameToVariable: {s.displayNameToVariable}\n" ++
    s!"  BVExprIdToFreeVar: {s.inputVarIdToVariable}\n" ++
    s!"  symVarToVal: {s.symVarToVal}" ++
    s!"  symVarToDisplayName: {s.symVarIdToVariable}"


instance : ToMessageData (ParsedInputState) where
  toMessageData s := printParsedFpExprState s

instance : ToString (ParsedInputState) where
  toString s := printParsedFpExprState s

-- TODO: can this live in Hydra?
structure ParsedFpExpr where
  width : Nat
  bvExpr: FpExpr width
  symVars: Std.HashMap Nat BVExpr.PackedBitVec
  inputVars : Std.HashMap Nat HydraVariable

-- | TODO: Can this live in Hydra?
abbrev ParsedFpLogicalExpr :=
  ParsedLogicalExpr ParsedFpExpr GenFpLogicalExpr

#check PackedFloat 10 20

structure PackedFloatTyExpr where
  m : Expr
  e : Expr

def getPackedFloatTy? (e : Expr) : MetaM (Option (PackedFloatTyExpr)) := do
  let eType ← inferType e
  match_expr eType with
  | PackedFloat m e => return some {m, e}
  | _ => return none

-- | TODO: Allow ParseExprM to throw errors, instead of returning an Option in many cases.
partial def toFpExpr (expr : Expr) (width: Nat) : ParseExprM (Option (FpExprWrapper)) := do
  let t ← inferType expr
  let some packedFloatTy ← getPackedFloatTy? expr | throwError m!"Could not determine the packed float type of {expr} : {t}"
  match_expr expr with
  | add a b => throwError "found 'add' node"
  | _ =>
      -- logInfo m!"failed to convert {expr} into an FpExpr."
  return none
/-
  go expr
  where
  go (x : Expr) : ParseExprM (Option (FpExprWrapper)) := do
    match_expr x with
    | HAdd.hAdd _ _ resType _ lhsExpr rhsExpr =>
        binaryReflection lhsExpr rhsExpr resType FpBinOp.add
    | _ =>
        let natVal ← getNatValue? x
        let bitVecVal ← getBitVecValue? x

        match (natVal, bitVecVal) with
        | (some v, none) =>
              let currState: ParsedInputState  ← get
              let pbv : BVExpr.PackedBitVec := {bv := BitVec.ofNat currState.originalWidth v}
              -- | TODO: why is this not a separate function?
              let existingVal :=  currState.valToSymVar[pbv]?

              match existingVal with
              | none => let numSymVars := currState.numSymVars
                        let newId := 1001 + numSymVars
                        let newExpr : FpExpr width := FpExpr.var newId
                        let userFacingName := Lean.Name.mkSimple s!"C{numSymVars + 1}"
                        let var : HydraVariable := {name := userFacingName, id := newId, width := width}

                        let updatedState : ParsedInputState  := { currState with
                                                                numSymVars := numSymVars + 1
                                                                , symVarToVal := currState.symVarToVal.insert newId pbv
                                                                , valToSymVar := currState.valToSymVar.insert pbv newId
                                                                , displayNameToVariable := currState.displayNameToVariable.insert userFacingName var
                                                                , symVarIdToVariable := currState.symVarIdToVariable.insert newId var}
                        set updatedState
                        return some {bvExpr := newExpr, width := width}
              | some var => let newExpr : FpExpr width := FpExpr.var var
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
            | some val => return some {bvExpr := FpExpr.var val.id, width := val.width}
            | none =>
                let newId := currState.maxFreeVarId + 1
                let newExpr : FpExpr w :=  FpExpr.var newId

                let var : HydraVariable := {name := userFacingName, id := newId, width := w}

                let updatedState : ParsedInputState :=  { currState with
                                                         maxFreeVarId := newId
                                                         , displayNameToVariable := currState.displayNameToVariable.insert userFacingName var
                                                         , inputVarIdToVariable := currState.inputVarIdToVariable.insert newId var
                                                         }
                set updatedState
                return some {bvExpr := newExpr, width := w}

  binaryReflection (lhsExpr rhsExpr resType : Expr) (op : FpBinOp) : ParseExprM (Option (FpExprWrapper)) := do
    let some lhs ← go lhsExpr | return none
    let some rhs ← go rhsExpr | return none
    let some w ← getWidth? resType | return none

    if h : w = lhs.width ∧ lhs.width = rhs.width then
      let rhs' := h.right ▸ rhs.bvExpr
      return some {bvExpr := FpExpr.bin lhs.bvExpr op rhs', width := lhs.width}
    else
      return none

  getConstantBVExpr? (nExpr : Expr) (vExpr : Expr) : ParseExprM (Option (FpExprWrapper)) := do
        let some n  ← getNatValue? nExpr | return none
        let some v ← getNatValue? vExpr | return none
        return some {bvExpr := FpExpr.const (BitVec.ofNat _ v), width := n }

  -- | TODO: this should be in Medusa/Util?
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

  -- | TODO: this should be in Medusa/Util?
  getWidth? (typeExpr : Expr) : MetaM (Option Nat) := do
    match_expr typeExpr with
    | BitVec n => getNatValue? n
    | _ => getNatValue? typeExpr

  processBitVec (pbv : BVExpr.PackedBitVec) : ParseExprM (Option FpExprWrapper) := do
    let currState: ParsedInputState ← get
    let existingVal :=  currState.valToSymVar[pbv]?
    match existingVal with
    | none =>
      let numSymVars := currState.numSymVars
      let newId := 1001 + numSymVars
      let newExpr : FpExpr pbv.w := FpExpr.var newId

      let userFacingName := Lean.Name.mkSimple s!"C{numSymVars + 1}"
      let var : HydraVariable := {name := userFacingName, id := newId, width := pbv.w}

      let updatedState : ParsedInputState := { currState with
                                              numSymVars := numSymVars + 1
                                              , symVarToVal := currState.symVarToVal.insert newId pbv
                                              , valToSymVar := currState.valToSymVar.insert pbv newId
                                              , displayNameToVariable := currState.displayNameToVariable.insert userFacingName var
                                              , symVarIdToVariable := currState.symVarIdToVariable.insert newId var}
      set updatedState
      return some {bvExpr := newExpr, width := pbv.w}
    | some var => let newExpr : FpExpr pbv.w := FpExpr.var var
                  return some {bvExpr := newExpr, width := pbv.w}
-/


def parseExprs (lhsExpr rhsExpr : Expr) (width : Nat): ParseExprM (Option ParsedFpLogicalExpr)  := do
  logInfo "C1.A"
  let some lhsRes ← toFpExpr lhsExpr width | throwError "Could not extract lhs: {lhsExpr}"
  let state ← get
  let lhs: ParsedFpExpr := {bvExpr := lhsRes.bvExpr, width := lhsRes.width, symVars := state.symVarToVal, inputVars := state.inputVarIdToVariable}
  throwError "C1.B"

  let some rhsRes ← toFpExpr rhsExpr width | throwError "Could not extract rhs: {rhsExpr}"
  let state ← get

  logInfo "C1.C"

  let rhsInputVars := state.inputVarIdToVariable.filter fun k _ => !lhs.inputVars.contains k
  let rhsSymVars := state.symVarToVal.filter fun k _ => !lhs.symVars.contains k

  throwError "C1.D"

  let rhs: ParsedFpExpr := {bvExpr := rhsRes.bvExpr, width := rhsRes.width, symVars := rhsSymVars, inputVars := rhsInputVars}
  logInfo "C1.E"

  trace[Generalize] m! "lhs width: {lhsRes.width}; rhs width: {rhsRes.width}"
  if h : lhsRes.width = rhsRes.width then
    throwError "C1.F"
    let rhsExpr := h ▸ rhsRes.bvExpr
    -- | TODO: why do we need it to be a 'BoolExpr'? We should have an interface
    -- that asks for it to be converted to a 'BoolExpr'.
    let bvLogicalExpr := BoolExpr.literal (FpPredicate.bin lhsRes.bvExpr FpBinaryPredKind.eq rhsExpr)
    trace[Generalize] m! "BVLogicalExpr: {bvLogicalExpr}"
    return some {lhs := lhs, rhs := rhs, state := state, logicalExpr := bvLogicalExpr}
  throwError "C1.G"

  return none

/-- info: Float.ofNat (n : Nat) : Float -/
#guard_msgs in #check Float.ofNat

def bvExprToExpr (ParsedFpExpr : ParsedFpLogicalExpr)
  (bvExpr : FpExpr w) : MetaM Expr := do
  let ParsedFpExprState := ParsedFpExpr.state
  let allVars := Std.HashMap.union ParsedFpExprState.inputVarIdToVariable ParsedFpExprState.symVarIdToVariable

  match bvExpr with
  | .var idx => let some var := allVars[idx]? | throwError m! "Could not find var: {idx} in {bvExpr}"
                let localDecl ← getLocalDeclFromUserName var.name
                pure (mkFVar localDecl.fvarId)
  | .bin lhs op rhs  =>
    match op with
    | .add => return mkApp3 (.const ``BitVec.add []) (mkNatLit w) (← bvExprToExpr ParsedFpExpr lhs) (← bvExprToExpr ParsedFpExpr rhs)
  -- | TODO: review this.
  | .const val => return mkApp2 (.const ``Float.ofNat []) (mkNatLit w) (mkNatLit (val.toNat))


def beqBitVecInstExpr (width : Expr) : Expr := mkApp2 (.const ``instBEqOfDecidableEq [levelZero]) (mkApp (mkConst ``BitVec) width) (mkApp (.const ``instDecidableEqBitVec []) width)
def beqBoolInstExpr : Expr := mkApp2 (.const ``instBEqOfDecidableEq [levelZero]) (mkConst ``Bool) (mkConst ``instDecidableEqBool)

def toExpr (_ParsedFpExpr : ParsedFpLogicalExpr) (bvLogicalExpr: GenFpLogicalExpr) : MetaM Expr := do
  go bvLogicalExpr
  where
  go (input : GenFpLogicalExpr) := do
  match input with
  | .literal x =>
      match x with
      | .bin _lhs .eq _rhs =>
        throwError "unimplemented toExpr go"
        -- return mkApp4 (.const ``BEq.beq [levelZero]) (mkApp (mkConst ``BitVec) (mkNatLit w)) (beqBitVecInstExpr (mkNatLit w)) (← bvExprToExpr ParsedFpExpr lhs) (← bvExprToExpr ParsedFpExpr rhs)
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
  | _ => throwError m! "Unsupported operation in toExpr"

/- def toFpExpr' (bvExpr : FpExpr w) : GeneralizerStateM (BVExpr w) := do
  match bvExpr with
  | .var idx => return BVExpr.var idx
  | .const val => return BVExpr.const val
  | .bin lhs op rhs  => return BVExpr.bin (← toFpExpr' lhs) op (← toFpExpr' rhs)
  | .un op expr =>  return BVExpr.un op (← toFpExpr' expr)
  | .append lhs rhs h => return BVExpr.append (← toFpExpr' lhs) (← toFpExpr' rhs) h
  | .replicate n expr h => return BVExpr.replicate n (← toFpExpr' expr) h
  | .shiftLeft lhs rhs =>  return BVExpr.shiftLeft (← toFpExpr' lhs) (← toFpExpr' rhs)
  | .shiftRight lhs rhs => return BVExpr.shiftRight (← toFpExpr' lhs) (← toFpExpr' rhs)
  | .arithShiftRight lhs rhs =>return BVExpr.arithShiftRight (← toFpExpr' lhs) (← toFpExpr' rhs)
  | _ => throwError m! "Unsupported operation provided: {bvExpr}"


def toBVLogicalExpr (bvLogicalExpr: GenFpLogicalExpr) : GeneralizerStateM BVLogicalExpr := do
  match bvLogicalExpr with
  | .literal (GenBVPred.bin lhs op rhs) => return BoolExpr.literal (BVPred.bin (← toFpExpr' lhs) op (← toFpExpr' rhs))
  | .const b => return BoolExpr.const b
  | .not boolExpr => return BoolExpr.not (← toBVLogicalExpr boolExpr)
  | .gate gate lhs rhs => return BoolExpr.gate gate (← toBVLogicalExpr lhs) (← toBVLogicalExpr rhs)
  | _ => throwError m! "Unsupported operation"
 -/
