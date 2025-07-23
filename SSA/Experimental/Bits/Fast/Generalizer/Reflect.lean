import Lean

import SSA.Core.Util
import SSA.Experimental.Bits.Fast.Generalizer.Basic

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
        logInfo m! "matched zero extend: {vExpr}"
        let some n ← getNatValue? nExpr | return none
        logInfo m! "vExpr: {vExpr}"
        let some v ← go vExpr | return none
        return some {bvExpr := GenBVExpr.zeroExtend n v.bvExpr, width := _}
    | BitVec.truncate _ nExpr vExpr =>
      logInfo m! "matched truncate: {vExpr}"
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
    logInfo m! "parsing: {e}"
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

  logInfo m! "lhs width: {lhsRes.width}; rhs width: {rhsRes.width}"
  if h : lhsRes.width = rhsRes.width then
    let rhsExpr := h ▸ rhsRes.bvExpr
    let bvLogicalExpr := BoolExpr.literal (GenBVPred.bin lhsRes.bvExpr BVBinPred.eq rhsExpr)
    logInfo m! "BVLogicalExpr: {bvLogicalExpr}"

    return some {lhs := lhs, rhs := rhs, state := state, bvLogicalExpr := bvLogicalExpr}

  return none
