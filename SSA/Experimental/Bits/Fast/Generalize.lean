
import Std.Sat.AIG.CNF
import Std.Sat.AIG.RelabelNat
import Std.Tactic.BVDecide.Bitblast.BVExpr
import Lean.Elab.Tactic.BVDecide.Frontend.BVDecide.Reify

import Lean.Elab.Term
import Lean.Meta.ForEachExpr
import Lean.Meta.Tactic.Simp.BuiltinSimprocs.BitVec
import Lean

import SSA.Core.Util

initialize Lean.registerTraceClass `Generalize
namespace Generalize


open Lean
open Lean.Meta
open Std.Sat
open Std.Tactic.BVDecide


instance : BEq BVExpr.PackedBitVec where
  beq a b := if h : a.w = b.w then
                let b' := h ▸ b.bv
                a.bv == b'
              else
                false

structure BVExprWrapper where
  width : Nat
  bvExpr: BVExpr width

structure ParsedBVExprState where
  maxFreeVarId : Nat
  maxSymVarId :  Nat
  inputVarToBVExpr : Std.HashMap FVarId BVExprWrapper
  inputBVExprVarToExpr : Std.HashMap Nat FVarId
  originalWidth : Nat
  symVarToVal : Std.HashMap Nat BVExpr.PackedBitVec


instance : ToString BVExpr.PackedBitVec where
  toString bitvec := toString bitvec.bv

instance [ToString α] [ToString β] [Hashable α] [BEq α] : ToString (Std.HashMap α β) where
  toString map :=
    "{" ++ String.intercalate ", " (map.toList.map (λ (k, v) => toString k ++ " → " ++ toString v)) ++ "}"

instance [ToString α] [Hashable α] [BEq α] : ToString (Std.HashSet α ) where
  toString set := toString set.toList

instance : ToString BVExprWrapper where
  toString w :=
      s!" BVExprWrapper \{width: {w.width}, bvExpr: {w.bvExpr}}"

instance : ToString FVarId where
  toString f := s! "{f.name}"

instance : Inhabited BVExprWrapper where
  default := {bvExpr := BVExpr.const (BitVec.ofNat 0 0), width := 0}

instance : Inhabited ParsedBVExprState where
  default := {maxFreeVarId := 0, maxSymVarId := 1000, originalWidth := 32, inputBVExprVarToExpr := {}, symVarToVal := {}, inputVarToBVExpr := {}}

def printParsedBVExprState (s: ParsedBVExprState) :=
    s!"ParsedBVExprState:\n" ++
    s!"  maxFreeVarId: {s.maxFreeVarId}\n" ++
    s!"  maxSymVarId: {s.maxSymVarId}\n" ++
    s!"  inputVarToBVExpr: {s.inputVarToBVExpr}\n" ++
    s!"  inputBVExprVarToExpr: {s.inputBVExprVarToExpr}\n" ++
    s!"  symVarToVal: {s.symVarToVal}¬"

instance : ToMessageData ParsedBVExprState where
  toMessageData s := printParsedBVExprState s


instance : ToString ParsedBVExprState where
  toString s := printParsedBVExprState s


structure ParsedBVExpr where
  width : Nat
  bvExpr: BVExpr width
  symVars: Std.HashMap Nat BVExpr.PackedBitVec
  inputVars : Std.HashMap Nat FVarId

structure ParsedBVLogicalExpr where
  lhs: ParsedBVExpr
  rhs: ParsedBVExpr
  bvLogicalExpr: BVLogicalExpr
  state: ParsedBVExprState


abbrev ParseBVExprM := StateRefT ParsedBVExprState MetaM

def changeBVExprWidth (bvExpr: BVExpr w) (target: Nat) : BVExpr target := Id.run do
  match bvExpr with
  | .var idx => (BVExpr.var idx : BVExpr target)
  | .const val => BVExpr.const (val.signExtend target)
  | .extract start len expr => BVExpr.extract start target (changeBVExprWidth expr (start + target))
  | .bin lhs op rhs => BVExpr.bin (changeBVExprWidth lhs target) op (changeBVExprWidth rhs target)
  | .un op operand => BVExpr.un op (changeBVExprWidth operand target)
  | .shiftLeft lhs rhs =>  BVExpr.shiftLeft (changeBVExprWidth lhs target)  (changeBVExprWidth rhs target)
  | .shiftRight lhs rhs =>  BVExpr.shiftRight (changeBVExprWidth lhs target) (changeBVExprWidth rhs target)
  | .arithShiftRight lhs rhs => BVExpr.arithShiftRight (changeBVExprWidth lhs target) (changeBVExprWidth rhs target)
  | _ => BVExpr.const (BitVec.zero target) -- TODO: How to handle 'append' and 'replicate'?

def changeBVLogicalExprWidth (bvLogicalExpr: BVLogicalExpr) (target: Nat): BVLogicalExpr :=
  match bvLogicalExpr with
  | .literal (BVPred.bin lhs op rhs) => BoolExpr.literal (BVPred.bin (changeBVExprWidth lhs target) op (changeBVExprWidth rhs target))
  | .not boolExpr =>
      BoolExpr.not (changeBVLogicalExprWidth boolExpr target)
  | .gate op lhs rhs =>
      BoolExpr.gate op (changeBVLogicalExprWidth lhs target) (changeBVLogicalExprWidth rhs target)
  | .ite constVar auxVar op3 =>
      BoolExpr.ite (changeBVLogicalExprWidth constVar target) (changeBVLogicalExprWidth auxVar target) (changeBVLogicalExprWidth op3 target)
  | _ => bvLogicalExpr

instance : Inhabited BVExpr.PackedBitVec where
  default := { bv := BitVec.ofNat 0 0 }

inductive SubstitutionValue where
    | bvExpr {w} (bvExpr : BVExpr w) : SubstitutionValue
    | packedBV  (bv: BVExpr.PackedBitVec) : SubstitutionValue

instance : Inhabited SubstitutionValue where
  default := SubstitutionValue.packedBV default

def bvExprToSubstitutionValue (map: Std.HashMap Nat (BVExpr w)) : Std.HashMap Nat SubstitutionValue :=
      Std.HashMap.ofList (List.map (fun item => (item.fst, SubstitutionValue.bvExpr item.snd)) map.toList)

def packedBitVecToSubstitutionValue (map: Std.HashMap Nat BVExpr.PackedBitVec) : Std.HashMap Nat SubstitutionValue :=
  Std.HashMap.ofList (List.map (fun item => (item.fst, SubstitutionValue.packedBV item.snd)) map.toList)

def substituteBVExpr (bvExpr: BVExpr w) (assignment: Std.HashMap Nat SubstitutionValue) : BVExpr w :=
    match bvExpr with
    | .var idx =>
      if assignment.contains idx then
          let value := assignment[idx]!
          match value with
          | .bvExpr (w := wbv) bv =>
            if h : w = wbv
            then h ▸ bv
            else BVExpr.extract 0 w bv
          | .packedBV packedBitVec =>  BVExpr.const (BitVec.ofNat w packedBitVec.bv.toNat)
      else bvExpr
    | .bin lhs op rhs =>
        BVExpr.bin (substituteBVExpr lhs assignment) op (substituteBVExpr rhs assignment)
    | .un op operand =>
        BVExpr.un op (substituteBVExpr operand assignment)
    | .shiftLeft lhs rhs =>
        BVExpr.shiftLeft (substituteBVExpr lhs assignment) (substituteBVExpr rhs assignment)
    | .shiftRight lhs rhs =>
        BVExpr.shiftRight (substituteBVExpr lhs assignment) (substituteBVExpr rhs assignment)
    | .arithShiftRight lhs rhs =>
        BVExpr.arithShiftRight (substituteBVExpr lhs assignment) (substituteBVExpr rhs assignment)
    -- | .extract start len expr =>
    --     BVExpr.extract start len (substituteBVExpr expr assignment)
    -- -- | .append lhs rhs =>
    --     BVExpr.append (substituteBVExpr lhs) (substituteBVExpr rhs)
    | _ => bvExpr --TODO: Handle other constructors


def substitute  (bvLogicalExpr: BVLogicalExpr) (assignment: Std.HashMap Nat SubstitutionValue) :
          BVLogicalExpr :=
  match bvLogicalExpr with
  | .literal (BVPred.bin lhs op rhs) => BoolExpr.literal (BVPred.bin (substituteBVExpr lhs assignment) op (substituteBVExpr rhs assignment))
  | .not boolExpr =>
      BoolExpr.not (substitute boolExpr assignment)
  | .gate op lhs rhs =>
      BoolExpr.gate op (substitute lhs assignment) (substitute rhs assignment)
  | .ite constVar auxVar op3 =>
      BoolExpr.ite (substitute constVar assignment) (substitute auxVar assignment) (substitute op3 assignment)
  | _ => bvLogicalExpr


/-
This function expects that targetWidth >= w
-/
def evalBVExpr (assignments : Std.HashMap Nat BVExpr.PackedBitVec) (targetWidth: Nat) (expr: BVExpr w) : BitVec targetWidth :=
  let newWidthExpr := changeBVExprWidth expr targetWidth
  let substitutedBvExpr := substituteBVExpr newWidthExpr (packedBitVecToSubstitutionValue assignments)

  let h : 0 < assignments.valuesArray.size := sorry
  let rArrayAssignments : BVExpr.Assignment  := RArray.ofArray assignments.valuesArray h
  BVExpr.eval rArrayAssignments substitutedBvExpr


def evalBVLogicalExpr (assignments : Std.HashMap Nat BVExpr.PackedBitVec) (targetWidth: Nat) (expr: BVLogicalExpr) : Bool :=
  let newWidthExpr := changeBVLogicalExprWidth expr targetWidth
  let substitutedBvExpr := substitute newWidthExpr (packedBitVecToSubstitutionValue assignments)

  let h : 0 < assignments.valuesArray.size := sorry
  let rArrayAssignments : BVExpr.Assignment  := RArray.ofArray assignments.valuesArray h
  BVLogicalExpr.eval rArrayAssignments substitutedBvExpr


--- Testing evalBVExpr

--(((0xff#8 << 0x00#8) >> var1002) << var1001)
-- def assignments := Std.HashMap.ofList [(1001, {bv := 0x00000008#32: BVExpr.PackedBitVec}),
--                                        ((1002, {bv := 0x00000010#32: BVExpr.PackedBitVec})),
--                                        ((1003, {bv := 0x00000008#32: BVExpr.PackedBitVec}))]

-- def zero := BVExpr.const (BitVec.ofNat 8 0)
-- def one := BVExpr.const (BitVec.ofNat 8 1 )
-- def minusOne := BVExpr.const (BitVec.ofInt 8 (-1))

-- def shift1 : BVExpr 8 := BVExpr.shiftLeft minusOne (BVExpr.var 1001 : BVExpr 8)
-- def shift2 : BVExpr 8 := BVExpr.shiftRight shift1 (BVExpr.var 1002 : BVExpr 8)

-- def finalShift : BVExpr 8 := BVExpr.shiftLeft shift2 (BVExpr.var 1003 : BVExpr 8)

-- #eval! evalBVExpr assignments 32 shift2
-- #eval! evalBVExpr assignments 32 finalShift

-- #eval (0x00000010#32).toNat
-- #eval ((0xffff#32).shiftLeft (0x00000008#32).toNat).ushiftRight (0x00000010#32).toNat
#eval (((BitVec.ofInt 32 (-1)).shiftLeft 8).ushiftRight 16).shiftLeft 8

def add (op1 : BVExpr w) (op2 : BVExpr w) : BVExpr w :=
  BVExpr.bin op1 BVBinOp.add op2

def negate (bvExpr: BVExpr w) : BVExpr w :=
  -- Two's complement value = 1 + Not(Var)
  BVExpr.bin (BVExpr.const (BitVec.ofNat w 1)) BVBinOp.add (BVExpr.un BVUnOp.not bvExpr)

def subtract (op1 : BVExpr w) (op2 : BVExpr w) : BVExpr w :=
  add op1 (negate op2)

def multiply (op1 : BVExpr w) (op2 : BVExpr w) : BVExpr w :=
  BVExpr.bin op1 BVBinOp.mul op2

def udiv {w} (op1 : BVExpr w) (op2 : BVExpr w) : BVExpr w :=
  BVExpr.bin op1 BVBinOp.udiv op2

def umod {w} (op1 : BVExpr w) (op2 : BVExpr w) : BVExpr w :=
  BVExpr.bin op1 BVBinOp.umod op2


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
          let rhs' := h ▸ rhs.bvExpr  -- cast rhs to BVExpr lhs.width
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
        return some {bvExpr := BVExpr.un BVUnOp.not inner.bvExpr, width := inner.width}
    | HShiftLeft.hShiftLeft _ _ _ _ innerExpr distanceExpr =>
        shiftReflection innerExpr distanceExpr BVExpr.shiftLeft
    | HShiftRight.hShiftRight _ _ _ _ innerExpr distanceExpr =>
        shiftReflection innerExpr distanceExpr BVExpr.shiftRight
    | BitVec.sshiftRight _ _ innerExpr distanceExpr =>
        shiftReflection innerExpr distanceExpr BVExpr.arithShiftRight
    | BitVec.sshiftRight' _ _ innerExpr distanceExpr =>
        shiftReflection innerExpr distanceExpr BVExpr.arithShiftRight
    | HAppend.hAppend _ _ _ _ lhsExpr rhsExpr =>
        let some lhs ← go lhsExpr | return none
        let some rhs ← go rhsExpr | return none
        return some {bvExpr := BVExpr.append lhs.bvExpr rhs.bvExpr rfl, width := _}
    | BitVec.extractLsb' _ _ _ _ =>
        throwError m! "Does not support BitVec.extractLsb' operations"
        -- let some start ← getNatValue? startExpr | return none
        -- let some len ← getNatValue? lenExpr | return none
        -- let some inner ← go innerExpr | return none
        -- return some {bvExpr := BVExpr.extract start len inner.bvExpr, width := len}
    | BitVec.rotateLeft _ innerExpr distanceExpr =>
        rotateReflection innerExpr distanceExpr BVUnOp.rotateLeft
    | BitVec.rotateRight _ innerExpr distanceExpr =>
        rotateReflection innerExpr distanceExpr BVUnOp.rotateRight
    -- | BitVec.truncate _ nExpr vExpr =>
    --   let some n ← go nExpr | return none
    --   let some v ← go vExpr | return none
    --   return some {bvExpr := BVExpr.const}
    --   throwError m! "Does not support truncate"
    --   -- return ⟨n, BitVec.truncate n v.snd⟩
    | Neg.neg _ _ a =>
          let currState: ParsedBVExprState ← get
          let newId := currState.maxSymVarId + 1
          let newExpr : BVExpr targetWidth := BVExpr.var newId

          let some (bvProd) ← getBitVecValue? a| return none

          let updatedState : ParsedBVExprState := { currState with maxSymVarId := newId, originalWidth := bvProd.fst, symVarToVal := currState.symVarToVal.insert newId {bv := -bvProd.snd: BVExpr.PackedBitVec}}
          set updatedState

          return some {bvExpr := newExpr, width := targetWidth}
    | _ =>
        let currState: ParsedBVExprState ← get
        let natVal ← getNatValue? x
        let bitVal ← getBitVecValue? x

        match (natVal, bitVal) with
        | (some v, none) =>
              let newId := currState.maxSymVarId + 1
              let bv : BitVec currState.originalWidth := BitVec.ofNat currState.originalWidth v
              let newExpr : BVExpr targetWidth := BVExpr.var newId

              let updatedState : ParsedBVExprState := { currState with maxSymVarId := newId, symVarToVal := currState.symVarToVal.insert newId {bv := bv: BVExpr.PackedBitVec}}
              set updatedState
              return some {bvExpr := newExpr, width := targetWidth}
        | (none, some bvProd) =>
              let newId := currState.maxSymVarId + 1
              let newExpr : BVExpr targetWidth := BVExpr.var newId

              let updatedState : ParsedBVExprState := { currState with maxSymVarId := newId, originalWidth := bvProd.fst, symVarToVal := currState.symVarToVal.insert newId {bv := bvProd.snd: BVExpr.PackedBitVec}}
              set updatedState
              return some {bvExpr := newExpr, width := targetWidth}
        | _ =>
            let .fvar name := x | throwError m! "Unknown expression: {x}"

            let existingVar? := currState.inputVarToBVExpr[name]?
            match existingVar? with
            | some val => return val
            | none =>
                let newId := currState.maxFreeVarId + 1
                let newExpr : BVExpr targetWidth :=  BVExpr.var newId
                let newWrappedExpr : BVExprWrapper := {bvExpr := newExpr, width := targetWidth}

                let updatedState : ParsedBVExprState := {currState with maxFreeVarId := newId, inputVarToBVExpr := currState.inputVarToBVExpr.insert name newWrappedExpr, inputBVExprVarToExpr := currState.inputBVExprVarToExpr.insert newId name}
                set updatedState
                return some newWrappedExpr

  rotateReflection (innerExpr: Expr) (distanceExpr : Expr) (rotateOp: Nat → BVUnOp)
          : ParseBVExprM (Option (BVExprWrapper)) := do
      let some inner ← go innerExpr | return none
      let some distance ← getNatValue? distanceExpr | return none
      return some {bvExpr := BVExpr.un (rotateOp distance) inner.bvExpr, width := inner.width}

  binaryReflection (lhsExpr rhsExpr : Expr) (op : BVBinOp) : ParseBVExprM (Option (BVExprWrapper)) := do
    let some lhs ← go lhsExpr | return none
    let some rhs ← go rhsExpr | return none

    if h : lhs.width = rhs.width then
      let rhs' := h ▸ rhs.bvExpr  -- cast rhs to BVExpr lhs.width
      return some {bvExpr := BVExpr.bin lhs.bvExpr op rhs', width := lhs.width}
    else
      return none

  shiftReflection (innerExpr : Expr) (distanceExpr : Expr) (shiftOp : {m n : Nat} → BVExpr m → BVExpr n → BVExpr m)
        : ParseBVExprM (Option (BVExprWrapper)) := do
      let some inner ← go innerExpr | return none
      let some distance ← go distanceExpr | return none
      return some {bvExpr :=  shiftOp inner.bvExpr distance.bvExpr, width := inner.width}


  getConstantBVExpr? (nExpr : Expr) (vExpr : Expr) : ParseBVExprM (Option (BVExprWrapper)) := do
        let some n  ← getNatValue? nExpr | return none
        let some v ← getNatValue? vExpr | return none

        return some {bvExpr := BVExpr.const (BitVec.ofNat n v), width := n}

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
    | BitVec.allOnes nExpr =>
      let n ← getNatValue? nExpr
      return ⟨n, BitVec.allOnes n⟩
    | BitVec.zeroExtend _ nExpr vExpr =>
      let n ← getNatValue? nExpr
      let v ← getBitVecValue? vExpr
      return ⟨n, BitVec.zeroExtend n v.snd⟩
    | BitVec.truncate _ nExpr vExpr =>
      let n ← getNatValue? nExpr
      let v ← getBitVecValue? vExpr
      return ⟨n, BitVec.truncate n v.snd⟩
    | _ =>
      let (v, type) ← getOfNatValue? e ``BitVec
      let n ← getNatValue? (← whnfD type.appArg!)
      return ⟨n, BitVec.ofNat n v⟩


def parseExprs (lhsExpr rhsExpr : Expr) (targetWidth : Nat): ParseBVExprM (Option ParsedBVLogicalExpr) := do
  let some lhsRes ← toBVExpr lhsExpr targetWidth | throwError "Could not extract lhs: {lhsExpr}"

  let state ← get
  let lhs: ParsedBVExpr := {bvExpr := lhsRes.bvExpr, width := lhsRes.width, symVars := state.symVarToVal, inputVars := state.inputBVExprVarToExpr}

  let some rhsRes ← toBVExpr rhsExpr targetWidth | throwError "Could not extract rhs: {rhsExpr}"
  let state ← get

  let rhsInputVars := state.inputBVExprVarToExpr.filter fun k _ => !lhs.inputVars.contains k
  let rhsSymVars := state.symVarToVal.filter fun k _ => !lhs.symVars.contains k

  let rhs: ParsedBVExpr := {bvExpr := rhsRes.bvExpr, width := rhsRes.width, symVars := rhsSymVars, inputVars := rhsInputVars}

  if h : lhsRes.width = rhsRes.width then
    let rhsExpr := h ▸ rhsRes.bvExpr
    let bvLogicalExpr := BoolExpr.literal (BVPred.bin lhsRes.bvExpr BVBinPred.eq rhsExpr)
    logInfo m! "BVLogicalExpr: {bvLogicalExpr}"

    return some {lhs := lhs, rhs := rhs, state := state, bvLogicalExpr := bvLogicalExpr}

  return none


def reconstructAssignment' (var2Cnf : Std.HashMap BVBit Nat) (assignment : Array (Bool × Nat))
    (aigSize : Nat)  :
    Std.HashMap Nat BVExpr.PackedBitVec := Id.run do
  let mut sparseMap : Std.HashMap Nat (RBMap Nat Bool Ord.compare) := {}

  for (bitVar, cnfVar) in var2Cnf.toArray do
    /-
    The setup of the variables in CNF is as follows:
    1. One auxiliary variable for each node in the AIG
    2. The actual BitVec bitwise variables
    Hence we access the assignment array offset by the AIG size to obtain the value for a BitVec bit.
    We assume that a variable can be found at its index as CaDiCal prints them in order.

    Note that cadical will report an assignment for all literals up to the maximum literal from the
    CNF. So even if variable or AIG bits below the maximum literal did not occur in the CNF they
    will still occur in the assignment that cadical reports.

    There is one crucial thing to consider in addition: If the highest literal that ended up in the
    CNF does not represent the highest variable bit not all variable bits show up in the assignment.
    For this situation we do the same as cadical for literals that did not show up in the CNF:
    set them to true.
    -/
    let idx := cnfVar + aigSize
    let varSet := if h : idx < assignment.size then assignment[idx].fst else true
    let mut bitMap := sparseMap.getD bitVar.var {}
    bitMap := bitMap.insert bitVar.idx varSet
    sparseMap := sparseMap.insert bitVar.var bitMap

  let mut finalMap := Std.HashMap.emptyWithCapacity
  for (bitVecVar, bitMap) in sparseMap.toArray do
    let mut value : Nat := 0
    let mut currentBit := 0
    for (bitIdx, bitValue) in bitMap.toList do
      assert! bitIdx == currentBit
      if bitValue then
        value := value ||| (1 <<< currentBit)
      currentBit := currentBit + 1
    finalMap := finalMap.insert bitVecVar ⟨BitVec.ofNat currentBit value⟩
  return finalMap

open Lean Elab Std Sat AIG Tactic BVDecide Frontend

def solve (bvExpr: BVLogicalExpr) : TermElabM (Option (Std.HashMap Nat BVExpr.PackedBitVec)) := do
    let cadicalTimeoutSec : Nat := 500
    let cfg: BVDecideConfig := {timeout := 500}

    IO.FS.withTempFile fun _ lratFile => do
      let ctx ← BVDecide.Frontend.TacticContext.new lratFile cfg
      let entry ← IO.lazyPure (fun _ => bvExpr.bitblast)

      let (cnf, map) ← IO.lazyPure (fun _ =>
            let (entry, map) := entry.relabelNat'
            let cnf := AIG.toCNF entry
            (cnf, map))

      let res ← runExternal cnf ctx.solver ctx.lratPath
          (trimProofs := true)
          (timeout := cadicalTimeoutSec)
          (binaryProofs := true)

      match res with
      | .ok _ =>
        return none
      | .error assignment =>
        let equations := reconstructAssignment' map assignment entry.aig.decls.size
        return .some equations


---- Test Solver function ----
def simpleArith : BVLogicalExpr :=
  let x := BVExpr.const (BitVec.ofNat 5 2)
  let y := BVExpr.const (BitVec.ofNat 5 4)
  let z : BVExpr 5 := BVExpr.var 0
  let sum : BVExpr 5 := BVExpr.bin x BVBinOp.add z
  BoolExpr.literal (BVPred.bin sum BVBinPred.eq y)

syntax (name := testExSolver) "test_solver" : tactic
@[tactic testExSolver]
def testSolverImpl : Tactic := fun _ => do
  let res ← solve simpleArith
  match res with
    | none => pure ()
    | some counterex =>
        for (id, var) in counterex do
          logInfo m! "Results: {id}={var.bv}"
  pure ()

-- theorem test_solver : False := by
--   test_solver

def addConstraints (expr: BVLogicalExpr) (constraints: List BVLogicalExpr) (op: Gate := Gate.and) : BVLogicalExpr :=
      match constraints with
      | [] => expr
      | x::xs =>
          addConstraints (BoolExpr.gate op expr x) xs op


def getIdentityAndAbsorptionConstraints (bvLogicalExpr: BVLogicalExpr) : TermElabM (List BVLogicalExpr) :=
      match bvLogicalExpr with
      | .literal (BVPred.bin lhs _ rhs) => return (← getBVExprConstraints lhs) ++ (← getBVExprConstraints rhs)
      | .not boolExpr => getIdentityAndAbsorptionConstraints boolExpr
      | .gate _ lhs rhs => return (← getIdentityAndAbsorptionConstraints lhs) ++ (← getIdentityAndAbsorptionConstraints rhs)
      | .ite constVar auxVar op3 =>
          return (← getIdentityAndAbsorptionConstraints constVar) ++ (← getIdentityAndAbsorptionConstraints auxVar) ++ (← getIdentityAndAbsorptionConstraints op3)
      | _ => pure []

      where
        getBVExprConstraints {w} (bvExpr : BVExpr w) : TermElabM (List BVLogicalExpr) :=
                match bvExpr with
                | .shiftRight (n := wbv) lhs rhs | .shiftLeft (n := wbv) lhs rhs | .arithShiftRight (n := wbv) lhs rhs =>
                      match rhs with
                      | BVExpr.var _ =>
                          if h : w = wbv then
                          let widthBV := h ▸ (BitVec.ofNat w w)
                          let zeroBV := h ▸ (BitVec.ofNat w 0)
                          let ltWidth := BoolExpr.literal (BVPred.bin (rhs) BVBinPred.ult (BVExpr.const (widthBV)))
                          let neqZero := BoolExpr.not (BoolExpr.literal (BVPred.bin (rhs) BVBinPred.eq (BVExpr.const zeroBV)))
                          return ( (← getBVExprConstraints lhs) ++ [ltWidth, neqZero])
                        else
                          throwError m! "Could not add shift constraints for {bvExpr}"
                      | _ => return (← getBVExprConstraints lhs) ++ (← getBVExprConstraints rhs)
                | .bin lhs op rhs  =>
                      if op == BVBinOp.or || op == BVBinOp.and then
                        match rhs with
                        | BVExpr.var _ =>
                            let neqZero := BoolExpr.not (BoolExpr.literal (BVPred.bin (rhs) BVBinPred.eq (BVExpr.const (BitVec.ofNat w 0))))
                            let neqAllOnes := BoolExpr.not (BoolExpr.literal (BVPred.bin (rhs) BVBinPred.eq (BVExpr.const (BitVec.allOnes w))))
                            return ( (← getBVExprConstraints lhs) ++ [neqZero, neqAllOnes])
                        | _ => return (← getBVExprConstraints lhs) ++ (← getBVExprConstraints rhs)
                      else return (← getBVExprConstraints lhs) ++ (← getBVExprConstraints rhs)
                | .un _ operand =>
                      return (← getBVExprConstraints operand)
                | _ => return []

partial def existsForAll (origExpr: BVLogicalExpr) (existsVars: List Nat) (forAllVars: List Nat)  (numExamples: Nat := 1):
                  TermElabM (List (Std.HashMap Nat BVExpr.PackedBitVec)) := do
    let rec constantsSynthesis (bvExpr: BVLogicalExpr) (existsVars: List Nat) (forAllVars: List Nat)
            : TermElabM (Option (Std.HashMap Nat BVExpr.PackedBitVec)) := do
      let existsRes ← solve bvExpr

      match existsRes with
        | none =>
          logInfo m! "Could not satisfy exists formula for {bvExpr}"
          return none
        | some assignment =>
          let existsVals := assignment.filter fun c _ => existsVars.contains c
          let substExpr := substitute bvExpr (packedBitVecToSubstitutionValue existsVals)
          let forAllRes ← solve (BoolExpr.not substExpr)

          match forAllRes with
            | none =>
              return some existsVals
            | some counterEx =>
                let newExpr := substitute bvExpr (packedBitVecToSubstitutionValue counterEx)
                constantsSynthesis (BoolExpr.gate Gate.and bvExpr newExpr) existsVars forAllVars

    let mut res : List (Std.HashMap Nat BVExpr.PackedBitVec) := []
    let identityAndAbsorptionConstraints ← getIdentityAndAbsorptionConstraints origExpr
    let targetExpr := (BoolExpr.gate Gate.and origExpr (addConstraints (BoolExpr.const True) (identityAndAbsorptionConstraints)))

    match numExamples with
    | 0 => return res
    | n + 1 =>  let consts ← constantsSynthesis targetExpr existsVars forAllVars
                match consts with
                | none => return res
                | some assignment =>
                      res := assignment :: res
                      let newConstraints := assignment.toList.map (fun c => BoolExpr.literal (BVPred.bin (BVExpr.var c.fst) BVBinPred.eq (BVExpr.const c.snd.bv)))
                      let constrainedBVExpr := BoolExpr.not (addConstraints (BoolExpr.const True) newConstraints)
                      return res ++ (← existsForAll (BoolExpr.gate Gate.and origExpr constrainedBVExpr) existsVars forAllVars n)



elab "#reducewidth" expr:term " : " target:term : command =>
  open Lean Lean.Elab Command Term in
  withoutModifyingEnv <| runTermElabM fun _ => Term.withDeclName `_reduceWidth do
      let targetExpr ← Term.elabTerm target (some (mkConst ``Nat))
      let some targetWidth ← getNatValue? targetExpr | throwError "Invalid width provided"

      let hExpr ← Term.elabTerm expr none
      logInfo m! "hexpr: {hExpr}"

      match_expr hExpr with
      | Eq _ lhsExpr rhsExpr =>
           let initialState : ParsedBVExprState := default
           let some (parsedBvExpr) ← (parseExprs lhsExpr rhsExpr targetWidth).run' initialState | throwError "Unsupported expression provided"

           let bvExpr := parsedBvExpr.bvLogicalExpr
           let state := parsedBvExpr.state
           logInfo m! "bvExpr: {bvExpr}, state: {state}"

           let results ← existsForAll bvExpr state.symVarToVal.keys state.inputBVExprVarToExpr.keys 3

           logInfo m! "Results: {results}"
      | _ =>
            logInfo m! "Could not match"
      pure ()

variable {x y z : BitVec 64}
#reducewidth (x + 0 = x) : 4

#reducewidth ((x <<< 8) >>> 16) <<< 8 = x &&& 0x00ffff00#64 : 4

#reducewidth (x <<< 3  = y + (BitVec.ofNat 64 3)) : 4

#reducewidth (x <<< 3) <<< 4 = x <<< 7 : 4

#reducewidth x + 5 = x : 8

#reducewidth x = 10 : 8

#reducewidth (x + (-21)) >>> 1 = x >>> 1 : 4

variable {x y z : BitVec 32}
#reducewidth 8#32 - x &&& 7#32 = 0#32 - x &&& 7#32 : 4

#reducewidth BitVec.sshiftRight' (x &&& ((BitVec.ofInt 32 (-1)) <<< (32 - y))) (BitVec.ofInt 32 32 - y) = BitVec.sshiftRight' x (BitVec.ofInt 32 32 - y) : 8
#reducewidth x <<< 6#32 <<< 28#32 = 0#32 : 4


def generateSketches (symVars: List (BVExpr w)) (operations : List (BVExpr w → BVExpr w → BVExpr w)) : List (BVExpr w) := Id.run do
    match symVars with
      | [] => symVars
      | _::[] => symVars
      | x::xs =>
          let remSketches := generateSketches xs operations
          let mut res : List (BVExpr w) := []
          for op in operations do
            for sketch in remSketches do
              res := (op x sketch) :: res

          res

def enumerativeSearch (lhsSketch: BVExpr w) (lhsSketchOnly: Bool) (inputs: List Nat)  (constants: Std.HashMap Nat BVExpr.PackedBitVec) (target: BVExpr.PackedBitVec) :
                      TermElabM ( List (BVExpr w)) := do

      logInfo m! "Running enumerative synthesis"
      let zero := BVExpr.const (BitVec.ofNat w 0)
      let one := BVExpr.const (BitVec.ofNat w 1 )
      let minusOne := BVExpr.const (BitVec.ofInt w (-1))

      let specialConstants := [zero, one, minusOne]

      let inputCombinations := productsList (List.replicate inputs.length specialConstants)

      let constantVars : List (BVExpr w) := constants.keys.map (λ c => BVExpr.var c)
      let constantsPermutation := productsList (List.replicate constantVars.length constantVars)

      let inputsAndConstants := List.product inputCombinations constantsPermutation

      let mut validCombos : List (BVExpr w) := []

      -- First process the LHS sketch. Here, we only replace inputs with special constants and symbolic constants with other symbolic constants to reduce the search space.
      --
      for combo in inputsAndConstants do
          let inputsSubstitutions := bvExprToSubstitutionValue (Std.HashMap.ofList (List.zip inputs combo.fst))
          let constantsSubstitutions := bvExprToSubstitutionValue (Std.HashMap.ofList (List.zip constants.keys combo.snd))

          let substitutedExpr := substituteBVExpr lhsSketch (Std.HashMap.union inputsSubstitutions constantsSubstitutions)
          let evaluatedExpr : BitVec target.w := evalBVExpr constants target.w substitutedExpr

          if evaluatedExpr == target.bv then
            validCombos := substitutedExpr :: validCombos

      if lhsSketchOnly then
          return validCombos

      -- Then process the enumerated sketches. We replace symbolic constants with both special constants and other symbolic constants.
      --- This enables us synthesize values like Cx + 0 = Target
      -- TODO: Do we want to process enumerated sketches even if we already have valid combo(s)?
      let enumeratedSketches := generateSketches constantVars [add, subtract, multiply, udiv]
      let specialConstantsSet := Std.HashSet.ofList specialConstants
      let constantsCombinations := (productsList (List.replicate constants.keys.length (constantVars ++ specialConstants))).filter (λ combo => let comboSet := Std.HashSet.ofList combo
                                                                                                                                               !(comboSet.all (λ c => specialConstantsSet.contains c)))
      for combo in constantsCombinations do
        let constantsSubstitutions := bvExprToSubstitutionValue (Std.HashMap.ofList (List.zip constants.keys combo))

        for sketch in enumeratedSketches do
          let substitutedExpr := substituteBVExpr sketch constantsSubstitutions
          let evaluatedExpr : BitVec target.w := evalBVExpr constants target.w substitutedExpr

            if evaluatedExpr == target.bv then
              validCombos := substitutedExpr :: validCombos

      return validCombos


partial def deductiveSearch (expr: BVExpr w) (inputs: List Nat) (constants: Std.HashMap Nat BVExpr.PackedBitVec) (target: BVExpr.PackedBitVec) (depth: Nat) (parent: Nat) :
                      TermElabM ( List (BVExpr w)) := do

    let updatePackedBVWidth (orig : BVExpr.PackedBitVec) (newWidth: Nat) : BVExpr.PackedBitVec :=
        if orig.w < newWidth then
            if orig.bv < 0 then
             {bv := orig.bv.signExtend newWidth, w := newWidth}
            else {bv := orig.bv.zeroExtend newWidth, w := newWidth}
        else if orig.w > newWidth then
            {bv := orig.bv.truncate newWidth, w := newWidth}
        else
            orig

    match depth with
      | 0 => return []
      | _ =>
            let mut res : List (BVExpr w) := []

            for (constId, constVal) in constants.toArray do
              if constId == parent then -- Avoid runaway expressions
                continue

              let newVar := BVExpr.var constId
              if constVal == target then
                res := newVar :: res
                continue

              if target.bv == 0 then
                res := BVExpr.const 0 :: res


              let newTarget := (updatePackedBVWidth target constVal.w)
              if h : constVal.w = newTarget.w then
                let targetBv := h ▸ newTarget.bv

                -- ~C = T
                if BitVec.not constVal.bv == targetBv then
                  res := BVExpr.un BVUnOp.not newVar :: res

                -- C + X = Target; New target = Target - X.
                let addRes ← deductiveSearch expr inputs constants {bv := targetBv - constVal.bv} (depth-1) constId
                res := res ++ addRes.map (λ resExpr => BVExpr.bin newVar BVBinOp.add resExpr)

                -- C - X = Target
                let subRes ← deductiveSearch expr inputs constants {bv := constVal.bv - targetBv} (depth-1) constId
                res := res ++ subRes.map (λ resExpr => BVExpr.bin newVar BVBinOp.add (negate resExpr))

                -- X - C = Target
                let subRes' ← deductiveSearch expr inputs constants {bv := targetBv + constVal.bv}  (depth-1) constId
                res := res ++ subRes'.map (λ resExpr => BVExpr.bin (resExpr) BVBinOp.add (negate newVar))

                -- X * C = Target
                if (BitVec.srem targetBv constVal.bv) == 0 && (BitVec.sdiv targetBv constVal.bv != 0) then
                  let mulRes ← deductiveSearch expr inputs constants {bv := BitVec.sdiv targetBv constVal.bv} (depth - 1) constId
                  res := res ++ mulRes.map (λ resExpr => BVExpr.bin newVar BVBinOp.mul resExpr)

                -- C / X = Target
                if targetBv != 0 && (BitVec.umod constVal.bv targetBv) == 0 then
                  let divRes ← deductiveSearch expr inputs constants {bv := BitVec.udiv constVal.bv targetBv} (depth - 1) constId
                  res := res ++ divRes.map (λ resExpr => BVExpr.bin newVar BVBinOp.udiv resExpr)

              else
                    throwError m! "Width mismatch for expr : {expr} and target: {target}"
            return res



def deductiveAndEnumerativeSearch (origWidthConstantsExpr reducedWidthConstantsExpr: ParsedBVLogicalExpr) (depth: Nat) :
                      TermElabM ( Std.HashMap Nat (List (BVExpr reducedWidthConstantsExpr.lhs.width))) := do

    let reducedWidth := reducedWidthConstantsExpr.lhs.width
    let mut results : Std.HashMap Nat (List (BVExpr reducedWidth)) := Std.HashMap.emptyWithCapacity

    let filterExprs (exprs : List (BVExpr reducedWidth)) (target : BVExpr.PackedBitVec) : TermElabM (List (BVExpr reducedWidth)) := do
        let mut res : List (BVExpr reducedWidth) := []
        for expr in (Std.HashSet.ofList exprs) do
          let evaluatedVal := evalBVExpr origWidthConstantsExpr.lhs.symVars target.w expr
          -- logInfo m! "Evaluated {expr} with values {origWidthConstantsExpr.lhs.symVars} and got result: {evaluatedVal}; Target = {target.bv}"
          if evaluatedVal == target.bv then
            res := expr :: res

        return res

    let inputVars := origWidthConstantsExpr.lhs.inputVars.keys
    let reducedWidthLhs := reducedWidthConstantsExpr.lhs
    let reducedWidthRhs := reducedWidthConstantsExpr.rhs

    for (targetId, targetVal) in reducedWidthRhs.symVars.toArray do
        let deductiveSearchRes := (← deductiveSearch reducedWidthLhs.bvExpr inputVars reducedWidthLhs.symVars targetVal depth 1234).map (λ c => changeBVExprWidth c reducedWidth)
        -- logInfo m! "Deductive search results: {deductiveSearchRes}"

        let lhsSketchRes ← enumerativeSearch reducedWidthLhs.bvExpr True inputVars reducedWidthLhs.symVars reducedWidthRhs.symVars[targetId]!

        let mut filteredExprs ← filterExprs (deductiveSearchRes ++ lhsSketchRes) origWidthConstantsExpr.rhs.symVars[targetId]!
        match filteredExprs with
        | [] =>
                logInfo m! "Could not synthesize an expression for {targetId} using deductive search and a sketch of the LHS; performing full enumerative synthesis"
                let enumSynthesisRes ← enumerativeSearch reducedWidthLhs.bvExpr False inputVars reducedWidthLhs.symVars targetVal

                if enumSynthesisRes.isEmpty then
                  logInfo m! "No candidate expressions generated from enumerative synthesis"
                  return Std.HashMap.emptyWithCapacity


                filteredExprs ← filterExprs enumSynthesisRes origWidthConstantsExpr.rhs.symVars[targetId]!
                if filteredExprs.isEmpty then
                  logInfo m! "Could not synthesize an expression for var{targetId} from {reducedWidthConstantsExpr.lhs.bvExpr}"
                  return Std.HashMap.emptyWithCapacity

                results := results.insert targetId filteredExprs
        | _  => results := results.insert targetId filteredExprs

    return results

def updateConstantValues (bvExpr: ParsedBVExpr) (assignments: Std.HashMap Nat BVExpr.PackedBitVec)
             : ParsedBVExpr := {bvExpr with symVars := assignments.filter (λ id _ => bvExpr.symVars.contains id)}


structure IOSynthesisResults (w : Nat) where
  expressions : HashMap Nat (List (BVExpr w))
  constantAssignments : Nat × List (HashMap Nat BVExpr.PackedBitVec)


def synthesiseIOExpressions(parsedBVLogicalExpr : ParsedBVLogicalExpr) (targetWidth: Nat) :
                TermElabM (IOSynthesisResults targetWidth) := do
  let bvLogicalExpr := parsedBVLogicalExpr.bvLogicalExpr
  let state := parsedBVLogicalExpr.state

  let originalWidth := state.originalWidth

  logInfo m! "bvExpr: {bvLogicalExpr}, state: {state}"

  let mut constantAssignments := []

  if originalWidth > targetWidth then
    constantAssignments ← existsForAll bvLogicalExpr state.symVarToVal.keys state.inputBVExprVarToExpr.keys 3

  let mut processingWidth := targetWidth
  if constantAssignments.isEmpty then
    logInfo m! "Could not synthesize new constant values in width {targetWidth}"
    constantAssignments := state.symVarToVal :: constantAssignments
    processingWidth := originalWidth
  else
    logInfo m! "Generated constant values for {bvLogicalExpr} in width {targetWidth}: {constantAssignments}"

  let mut exprSynthesisResults : Std.HashMap Nat (Std.HashSet (BVExpr targetWidth)) := Std.HashMap.emptyWithCapacity
  for constantAssignment in constantAssignments do
    logInfo m! "Processing constants assignment: {constantAssignment}"
    let lhs := updateConstantValues parsedBVLogicalExpr.lhs constantAssignment
    let rhs := updateConstantValues parsedBVLogicalExpr.rhs constantAssignment
    let synthesisWidthBVLogicalExpr := {parsedBVLogicalExpr with lhs := lhs, rhs := rhs}

    let res ←  withTraceNode `Generalize (fun _ => return "Performed enumerative and deductive search") do
                                    deductiveAndEnumerativeSearch parsedBVLogicalExpr synthesisWidthBVLogicalExpr 3
    logInfo m! "Expression synthesis results for assignment: {constantAssignment} is {res}"

    let h : targetWidth = synthesisWidthBVLogicalExpr.lhs.width := sorry
    for (var, exprs) in res.toArray do
      let mut exprsForSymVar := exprSynthesisResults.getD var Std.HashSet.emptyWithCapacity
      exprsForSymVar := exprsForSymVar.insertMany (exprs.map (λ expr => h ▸ expr))
      exprSynthesisResults := exprSynthesisResults.insert var exprsForSymVar

  if exprSynthesisResults.values.any (fun v => v.isEmpty) then
    throwError m! "Could not synthesise expressions for {bvLogicalExpr}"

  let filteredExprSynthesisResults ←  withTraceNode `Generalize (fun _ => return "Pruned equivalent expressions") do
    let mut tempResults : Std.HashMap Nat (List (BVExpr targetWidth)) := Std.HashMap.emptyWithCapacity
    for (var, expressions) in exprSynthesisResults.toList do
      let mut filtered : List (BVExpr targetWidth) := []

      logInfo m! "Synthesised expressions for {var} before filtering had {expressions.size} results"
      for expr in expressions do
        if filtered.isEmpty then
          filtered := expr :: filtered
          continue

        let newConstraints := filtered.map (fun f =>  BoolExpr.not (BoolExpr.literal (BVPred.bin f BVBinPred.eq expr)))
        let subsumeCheckExpr :=  addConstraints (BoolExpr.const True) newConstraints

        if let some _ ← solve subsumeCheckExpr then
          filtered := expr :: filtered

      logInfo m! "Removed {expressions.size - filtered.length} expressions after filtering"
      tempResults := tempResults.insert var filtered

    return tempResults

  return {expressions := filteredExprSynthesisResults, constantAssignments := (processingWidth, constantAssignments)}


elab "#iosynthesize" expr:term: command =>
  open Lean Lean.Elab Command Term in
  withoutModifyingEnv <| runTermElabM fun _ => Term.withDeclName `_reduceWidth do
      let targetWidth := 8

      let hExpr ← Term.elabTerm expr none
      -- let hExpr ← instantiateMVars (← whnfR  hExpr)
      logInfo m! "hexpr: {hExpr}"

      match_expr hExpr with
      | Eq _ lhsExpr rhsExpr =>
           let initialState : ParsedBVExprState := default
           let some parsedBVLogicalExpr ← (parseExprs lhsExpr rhsExpr targetWidth).run' initialState | throwError "Unsupported expression provided"

           let res ← synthesiseIOExpressions parsedBVLogicalExpr targetWidth
           logInfo m! "Expression synthesis results for {parsedBVLogicalExpr.bvLogicalExpr} over all assignments: {res.expressions}"

      | _ =>
            throwError m! "Could not match"
      pure ()


-- variable {x y z: BitVec 8}
-- #iosynthesize (x ^^^ -1#8 ||| 7#8) ^^^ 12#8 = x &&& BitVec.ofInt 8 (-8)
-- #iosynthesize  x <<< 1#8 ^^^ y <<< 1#8 &&& 20#8 = (x ^^^ y &&& 10#8) <<< 1#8
-- #iosynthesize x <<< 1#8 + (y <<< 1#8 &&& 119#8) = (x + (y &&& 59#8)) <<< 1#8
-- #iosynthesize (x ^^^ 33#8 ||| 7#8) ^^^ 12#8 = x &&& BitVec.ofInt 8 (-8) ^^^ 43#8
-- #iosynthesize  x <<< 1#8 ^^^ y <<< 1#8 &&& 20#8 = (x ^^^ y &&& 10#8) <<< 1#8

-- variable {x y z: BitVec 32}
-- #iosynthesize x + 10 + 1 =  x + 9 + 2
-- #iosynthesize x + 10 + y + 14 = 24

-- -- #iosynthesize (x &&& ((BitVec.ofInt 32 (-1)) <<< (32 - y))) >>> (32 - y) = x >>> (32 - y)

-- #iosynthesize (x <<< 3) <<< 4 = x <<< 7
-- #iosynthesize (x + 5) + (y + 1)  =  x + y + 6
-- #iosynthesize (x + 5) - (y + 1)  =  x - y + 4
-- #iosynthesize ((x <<< 8) >>> 16) <<< 8 = x &&& 0x00ffff00#32
-- #iosynthesize 8#32 - x &&& 7#32 = 0#32 - x &&& 7#32
-- #iosynthesize ((x ^^^ 1234#32) >>> 8#32 ^^^ 1#32) + (x ^^^ 1234#32) = (x >>> 8#32 ^^^ 5#32) + (x ^^^ 1234#32)
-- -- #iosynthesize x * 42#32 ^^^ (y * 42#32 ^^^ z * 42#32) ||| z * 42#32 ^^^ x * 42#32 = z * 42#32 ^^^ x * 42#32 ||| y * 42#32
-- -- #iosynthesize  ((x >>> 4#32 &&& 8#32) + y) <<< 4#32 = (x &&& 128#32) + y <<< 4#32

-- variable {x y z: BitVec 4}
-- #iosynthesize  (x <<< 2#4) ^^^ y <<< 2#4 &&& 8#4 = (x ^^^ y &&& 0xa#4) <<< 2#4

instance : BEq BVLogicalExpr where
  beq := fun a b => toString a == toString b

instance : Hashable BVLogicalExpr where
  hash a := hash (toString a)


partial def countModel (expr : BVLogicalExpr) (constants: Std.HashSet Nat): TermElabM Nat := do
    go 0 expr
    where
        go (count: Nat) (expr : BVLogicalExpr) : TermElabM Nat := do
          let res ← solve expr
          match res with
          | none => return count
          | some assignment =>
                let filteredAssignments := assignment.filter (λ c _ => constants.contains c)
                let newConstraints := filteredAssignments.toList.map (fun c => BoolExpr.literal (BVPred.bin (BVExpr.var c.fst) BVBinPred.eq (BVExpr.const c.snd.bv)))
                let constrainedBVExpr := BoolExpr.not (addConstraints (BoolExpr.const True) newConstraints)

                if count + 1 > 1000 then
                  return count
                pure (← go (count + 1) (BoolExpr.gate Gate.and expr constrainedBVExpr))

def generateCombinations (num: Nat) (values: List α) : List (List α) :=
    match num, values with
    | 0, _ => [[]]
    | _, [] => []
    | n + 1, x::xs =>
            let combosWithoutX := (generateCombinations (n + 1) xs)
            let combosWithX := (generateCombinations n xs).map (λ combo => x :: combo)
            combosWithoutX ++ combosWithX

def getNegativeExamples (bvExpr: BVLogicalExpr) (consts: List Nat) (numEx: Nat) :
              TermElabM (List (Std.HashMap Nat BVExpr.PackedBitVec)) := do
  let identityAndAbsorptionConstraints ← getIdentityAndAbsorptionConstraints bvExpr
  let targetExpr := BoolExpr.gate Gate.and (BoolExpr.not bvExpr) (addConstraints (BoolExpr.const True) (identityAndAbsorptionConstraints))
  return (← helper targetExpr numEx)
  where
        helper (expr: BVLogicalExpr) (depth : Nat)
          : TermElabM (List (Std.HashMap Nat BVExpr.PackedBitVec)) := do
        match depth with
          | 0 => return []
          | n + 1 =>
              let solution ← solve expr

              match solution with
              | none => return []
              | some assignment =>
                   let constVals := assignment.filter fun c _ => consts.contains c
                   let newConstraints := constVals.toList.map (fun c => BoolExpr.not (BoolExpr.literal (BVPred.bin (BVExpr.var c.fst) BVBinPred.eq (BVExpr.const c.snd.bv))))

                   let res ← helper (addConstraints expr newConstraints) n
                   return [constVals] ++ res


def generatePreconditions (originalBVLogicalExpr : ParsedBVLogicalExpr) (reducedWidthBVLogicalExpr: BVLogicalExpr) (positiveExamples negativeExamples: List (Std.HashMap Nat BVExpr.PackedBitVec)) (widthIdAndVal: Nat × Nat)
              (numConjunctions: Nat := 0) : TermElabM (Option BVLogicalExpr) := do

    let widthId := widthIdAndVal.fst
    let bitwidth := widthIdAndVal.snd

    let constants := widthId :: positiveExamples[0]!.keys

    let maxConstantId := constants.max?
    match maxConstantId with
    | none => return none
    | some max =>
          let symbolicVarIds : List Nat := (List.range constants.length).map (fun c => max + c + 1)
          let symbolicVars : List (BVExpr bitwidth) := symbolicVarIds.map (fun c => BVExpr.var c)

          logInfo m! "Symbolic vars: {symbolicVars}"

          let expressionSketches := generateSketches symbolicVars [add, subtract, umod]

          logInfo m! "Generated {expressionSketches.length} sketches: {expressionSketches}"

          let zero := BVExpr.const (BitVec.ofNat bitwidth 0)
          let one := BVExpr.const (BitVec.ofNat bitwidth 1)
          let minusOne := BVExpr.const (BitVec.ofInt bitwidth (-1))

          let specialConstants := [zero, one]
          let sketchInputs := (constants.map (fun c => BVExpr.var c)) ++ specialConstants ++ (constants.map (fun c => BVExpr.un BVUnOp.not (BVExpr.var c)))
          let mut inputCombinations := productsList (List.replicate constants.length sketchInputs)

          let specialConstantsSet := Std.HashSet.ofList specialConstants
          inputCombinations := inputCombinations.filter (fun combo =>
                                                            let comboSet := Std.HashSet.ofList combo
                                                            !(comboSet.all (λ c => specialConstantsSet.contains c))
                                                      )

          let eqToZero (expr: BVExpr bitwidth) : BVLogicalExpr :=
            BoolExpr.literal (BVPred.bin expr BVBinPred.eq zero)

          let positive (expr: BVExpr bitwidth) : BVLogicalExpr :=
            let shiftDistance : BVExpr bitwidth := BVExpr.bin (BVExpr.var widthId) BVBinOp.add (negate one)
            let mask := BVExpr.shiftLeft one shiftDistance
            let maskAndExpr : BVExpr bitwidth := BVExpr.bin expr BVBinOp.and mask  -- It's positive if (expr && (1 << width -1) == 0)

            eqToZero maskAndExpr

          let strictlyGTZero (expr: BVExpr bitwidth) : BVLogicalExpr :=
            BoolExpr.gate  Gate.and (BoolExpr.not (eqToZero expr)) (positive expr)

          let gteZero (expr: BVExpr bitwidth) : BVLogicalExpr :=
             positive expr

          let negative (expr: BVExpr bitwidth) : BVLogicalExpr :=
            BoolExpr.not (positive expr)

          let strictlyLTZero (expr: BVExpr bitwidth) : BVLogicalExpr :=
            negative expr

          let lteZero (expr: BVExpr bitwidth) : BVLogicalExpr :=
            BoolExpr.gate Gate.or (eqToZero expr) (negative expr)

          let reducedWidthSubstitutionVal := bvExprToSubstitutionValue (Std.HashMap.ofList [(widthId, BVExpr.const (BitVec.ofNat bitwidth bitwidth))])

          let preconditionCandidates ← withTraceNode `Generalize (fun _ => return "Generated valid expression sketches") do
            let mut preconditionCandidates : List BVLogicalExpr := []

            -- Check for power of 2: const & (const - 1) == 0
            for const in positiveExamples[0]!.keys do
              let powerOf2Expr :=  BVExpr.bin (BVExpr.var const) BVBinOp.and (BVExpr.bin (BVExpr.var const) BVBinOp.add minusOne)
              let powerOfTwoResults := positiveExamples.map (λ pos => evalBVExpr pos bitwidth powerOf2Expr)

              if powerOfTwoResults.any (λ val => val == 0) then
                let powerOf2 := BoolExpr.literal (BVPred.bin powerOf2Expr BVBinPred.eq zero)
                preconditionCandidates := powerOf2 :: preconditionCandidates

            let mut sketchResults : Std.HashSet String := Std.HashSet.emptyWithCapacity -- Used to filter "observationally equivalent sketches"

            for combo in inputCombinations do
              for sketch in expressionSketches do
                let symbolicVarsSubstitution := Std.HashMap.ofList (List.zip symbolicVarIds combo)
                let substitutedExpr := substituteBVExpr sketch (bvExprToSubstitutionValue symbolicVarsSubstitution)

                let widthSubstitutedExpr := substituteBVExpr substitutedExpr reducedWidthSubstitutionVal
                let evaluatedPositiveExs := positiveExamples.map (λ pos => (evalBVExpr pos bitwidth widthSubstitutedExpr).toInt)
                let evaluatedNegativeExs := negativeExamples.map (λ neg => (evalBVExpr neg bitwidth widthSubstitutedExpr).toInt)

                let resultsString := toString (evaluatedPositiveExs ++ evaluatedNegativeExs)
                if sketchResults.contains resultsString then
                  continue

                sketchResults := sketchResults.insert resultsString

                if (evaluatedPositiveExs.all ( λ val => val == 0)) && evaluatedNegativeExs.all (λ val => val != 0) then
                  preconditionCandidates := eqToZero substitutedExpr :: preconditionCandidates
                  continue

                if (evaluatedPositiveExs.any ( λ val => val < 0 || val == 0)) && evaluatedNegativeExs.all (λ val => val > 0) then
                  let mut cand := lteZero substitutedExpr
                  if (evaluatedPositiveExs.all ( λ val => val < 0)) then
                    cand := strictlyLTZero substitutedExpr

                  preconditionCandidates := cand :: preconditionCandidates

                if (evaluatedPositiveExs.any ( λ val => val > 0 || val == 0)) && evaluatedNegativeExs.all (λ val => val < 0) then
                  let mut cand := gteZero substitutedExpr
                  if (evaluatedPositiveExs.all ( λ val => val > 0)) then
                      cand := strictlyGTZero substitutedExpr

                  preconditionCandidates := cand :: preconditionCandidates

            pure preconditionCandidates

          let preconditionCandidatesSet := Std.HashSet.ofList preconditionCandidates
          let reducedWidthSubstitutedBVLogicalExpr := substitute reducedWidthBVLogicalExpr  reducedWidthSubstitutionVal

          let validCandidates ← withTraceNode `Generalize (fun _ => return "Filtered out invalid expression sketches") do
            let mut validCandidates : List BVLogicalExpr := []

            let mut candidates := preconditionCandidatesSet
            if numConjunctions >= 1 then
              let combinations := generateCombinations numConjunctions candidates.toList
              candidates := Std.HashSet.ofList (combinations.map (λ comb => addConstraints (BoolExpr.const True) comb))

            let widthConstraint : BVLogicalExpr := BoolExpr.literal (BVPred.bin (BVExpr.var widthId) BVBinPred.eq (BVExpr.const (BitVec.ofNat bitwidth bitwidth)))

            logInfo m! "Originally processing {candidates.size} candidates"
            let mut numInvocations := 0
            while !candidates.isEmpty do
              let expressionsConstraints : BVLogicalExpr := addConstraints (BoolExpr.const False) candidates.toList Gate.or
              let expr := BoolExpr.gate Gate.and (addConstraints expressionsConstraints [widthConstraint]) (BoolExpr.not reducedWidthSubstitutedBVLogicalExpr)

              let mut newCandidates : Std.HashSet BVLogicalExpr := Std.HashSet.emptyWithCapacity
              numInvocations := numInvocations + 1
              match (← solve expr) with
              | none => break
              | some assignment =>
                  newCandidates ← withTraceNode `Generalize (fun _ => return "Evaluated expressions for filtering") do
                    let mut res : Std.HashSet BVLogicalExpr := Std.HashSet.emptyWithCapacity
                    for candidate in candidates do
                      let widthSubstitutedCandidate := substitute candidate reducedWidthSubstitutionVal
                      if !(evalBVLogicalExpr assignment bitwidth widthSubstitutedCandidate) then
                        res := res.insert candidate
                    pure res

              candidates := newCandidates

            logInfo m! "Invoked the solver {numInvocations} times for {preconditionCandidatesSet.size} potential candidates."
            validCandidates := candidates.toList
            pure validCandidates

          logInfo m! "Original had {preconditionCandidatesSet.size} candidates. Remaining candidates has length: {validCandidates.length}"

          if validCandidates.isEmpty then
            return none

          if validCandidates.length == 1 then
            return validCandidates[0]?

          -- Prune expressions
          let prunedResults ← withTraceNode `Generalize (fun _ => return "Pruned equivalent valid precondition candidates") do
            let mut pruned: List BVLogicalExpr:= []
            for cand in validCandidates do
              if pruned.isEmpty then
                pruned := cand :: pruned
                continue

              let newConstraints := pruned.map (fun f =>  BoolExpr.not (BoolExpr.gate Gate.beq f cand))
              let subsumeCheckExpr :=  addConstraints (BoolExpr.const True) newConstraints

              if let some _ ← solve subsumeCheckExpr then
                pruned := cand :: pruned

            pure pruned
          logInfo m! "Pruned {validCandidates.length - prunedResults.length} equivalent expressions"

          --- Rank valid candidates by model counting
          let candidateByModelCount ← withTraceNode `Generalize (fun _ => return "Ranked candidates by model count") do -- TODO: Do we even need model counting??
            let mut candidateByModelCount : List (Nat × BVLogicalExpr) := []
            let constantsSet := Std.HashSet.ofList constants
            for candidate in prunedResults do
            -- for candidate in validCandidates do
              let widthSubstitutedCandidate := substitute candidate reducedWidthSubstitutionVal
              let count ← countModel widthSubstitutedCandidate constantsSet
              candidateByModelCount := (count, candidate) :: candidateByModelCount

            candidateByModelCount := candidateByModelCount.mergeSort (λ a b => a.fst > b.fst)
            pure candidateByModelCount

          logInfo m! "Candidate by model count: {candidateByModelCount}"

          let combinedPred ← withTraceNode `Generalize (fun _ => return "Combined predicates") do
            let mut combinedPred : Option BVLogicalExpr := none
            let mut count := 0
            for (_, candidate) in candidateByModelCount do
              match combinedPred with
              | none =>
                  combinedPred := some candidate
                  count := count + 1
              | some wp => --- TODO: we might not need this subsumption logic given that we prune equivalent expressions
                  if let some _ ← solve (BoolExpr.gate Gate.and wp (BoolExpr.not candidate)) then
                      combinedPred := some (BoolExpr.gate Gate.or wp candidate)
                      count := count + 1
                  else
                      logInfo m! "Candidate {candidate} is already covered by {combinedPred}"

            logInfo m! "Candidates by model count size: {candidateByModelCount.length}; combined count: {count}"
            pure combinedPred

          match combinedPred with
          | some pred =>
              let widthSubstitutedPred := substitute pred reducedWidthSubstitutionVal
              if let some assignment ← solve (BoolExpr.gate Gate.and widthSubstitutedPred (BoolExpr.not reducedWidthSubstitutedBVLogicalExpr)) then
                  throwError m! "Precondition logic has failed o; found an assignment for {pred}: {assignment}"
          | none => return none

          return combinedPred



elab "#generalize" expr:term: command =>
  open Lean Lean.Elab Command Term in
  withoutModifyingEnv <| runTermElabM fun _ => Term.withDeclName `_reduceWidth do
      let targetWidth := 8

      let hExpr ← Term.elabTerm expr none
      logInfo m! "hexpr: {hExpr}"
      let timeoutMs := 600000

      match_expr hExpr with
      | Eq _ lhsExpr rhsExpr =>
           let startTime ← Core.liftIOCore IO.monoMsNow

           let initialState : ParsedBVExprState := default
           let some parsedBVLogicalExpr ← (parseExprs lhsExpr rhsExpr targetWidth).run' initialState
             | throwError "Unsupported expression provided"

           let bvLogicalExpr := parsedBVLogicalExpr.bvLogicalExpr
           let state := parsedBVLogicalExpr.state

           logInfo m! "bvExpr: {bvLogicalExpr}, state: {state}"
           let exprSynthesisResults ← synthesiseIOExpressions parsedBVLogicalExpr targetWidth
           logInfo m! "Expression synthesis results for {parsedBVLogicalExpr.bvLogicalExpr} over all assignments: {exprSynthesisResults.expressions}"

           /-
            Here, we evaluate generated preconditions for different combinations of target values on the RHS.
            If we have only one target on the RHS, then we're just going through the list of the generated expressions.
           -/
           let resultsCombo := productsList exprSynthesisResults.expressions.values
           let (positiveExamplesWidth, constantAssignments) := exprSynthesisResults.constantAssignments
           let positiveExamples := constantAssignments.map (fun assignment => assignment.filter (fun key _ => parsedBVLogicalExpr.lhs.symVars.contains key))

            let negativeExamplesPerCombo : TermElabM (List (BVLogicalExpr × (List (HashMap ℕ BVExpr.PackedBitVec)))) := withTraceNode `Generalize (fun _ => return "Generated negative examples for all combos") do

                let mut res : List (BVLogicalExpr × (List (HashMap ℕ BVExpr.PackedBitVec))) := []
                  --- First check if there are any expressions that don't require a precondition
                for combo in resultsCombo do
                  -- Substitute the generated expressions into the main one, so the constants on the RHS are expressed in terms of the left.
                  let zippedCombo := Std.HashMap.ofList (List.zip parsedBVLogicalExpr.rhs.symVars.keys combo)
                  let substitutedBVLogicalExpr := substitute bvLogicalExpr (bvExprToSubstitutionValue zippedCombo)

                  let negativeExamples ← getNegativeExamples substitutedBVLogicalExpr positiveExamples[0]!.keys 3
                  if negativeExamples.isEmpty then do
                      logInfo m! "General form: {substitutedBVLogicalExpr} has no preconditions."
                      return []

                  res := (substitutedBVLogicalExpr, negativeExamples) :: res

                return res

           let preconditionSuccess : TermElabM Bool :=  withTraceNode `Generalize (fun _ => return "Attempted to generate weak precondition for all expression combos") do
              -- Then attempt to generate preconditions
              for numConjunctions in (List.range 1) do
                logInfo m! "Running with {numConjunctions} allowed conjunctions"
                for (substitutedBVLogicalExpr, negativeExamples)  in (←  negativeExamplesPerCombo) do
                    let widthId := 9481

                    let precondition ← withTraceNode `Generalize (fun _ => return m! "Attempted to generate weak precondition for {substitutedBVLogicalExpr}") do
                                  generatePreconditions parsedBVLogicalExpr substitutedBVLogicalExpr positiveExamples negativeExamples (widthId, positiveExamplesWidth) numConjunctions

                    match precondition with
                    | none => logInfo m! "Could not generate precondition for expr: {substitutedBVLogicalExpr} with negative examples: {negativeExamples}"
                    | some weakPC =>
                            logInfo m! "Expr: {substitutedBVLogicalExpr} has weak precondition: {weakPC}"
                            return True -- TODO: we then need to verify width independence

                    let currentTime ← Core.liftIOCore IO.monoMsNow
                    let elapsedTime := currentTime - startTime

                    trace[Generalize] m! "Elapsed time: {elapsedTime/1000}s"
                    if elapsedTime >= timeoutMs then
                        throwError m! "Synthesis Timeout Failure: Exceeded timeout of {timeoutMs/1000}s"

              return False

            if !(← negativeExamplesPerCombo).isEmpty && !(← preconditionSuccess) then
              throwError m! "Could not generalize {bvLogicalExpr}"

      | _ => throwError m!"The top level constructor is not an equality predicate in {hExpr}"
      pure ()

end Generalize
