
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


/--
Custom BVExpr for generalization incoroporating all supported expressions involving `BitVec` and operations on them.
-/
inductive GenBVExpr : Nat → Type where
  /--
  A `BitVec` variable, referred to through an index.
  -/
  | var (idx : Nat) : GenBVExpr w
  /--
  A constant `BitVec` value.
  -/
  | const (val : BitVec w) : GenBVExpr w
  /--
  Extract a slice from a `BitVec`.
  -/
  | extract (start len : Nat) (expr : GenBVExpr w) : GenBVExpr len
  /--
  A binary operation on two `BVExpr`.
  -/
  | bin (lhs : GenBVExpr w) (op : BVBinOp) (rhs : GenBVExpr w) : GenBVExpr w
  /--
  A unary operation on two `BVExpr`.
  -/
  | un (op : BVUnOp) (operand : GenBVExpr w) : GenBVExpr w
  /--
  Concatenate two bitvectors.
  -/
  | append (lhs : GenBVExpr l) (rhs : GenBVExpr r) (h : w = l + r) : GenBVExpr w
  /--
  Concatenate a bitvector with itself `n` times.
  -/
  | replicate (n : Nat) (expr : GenBVExpr w) (h : w' = w * n) : GenBVExpr w'
  /--
  shift left by another BitVec expression. For constant shifts there exists a `BVUnop`.
  -/
  | shiftLeft (lhs : GenBVExpr m) (rhs : GenBVExpr n) : GenBVExpr m
  /--
  shift right by another BitVec expression. For constant shifts there exists a `BVUnop`.
  -/
  | shiftRight (lhs : GenBVExpr m) (rhs : GenBVExpr n) : GenBVExpr m
  /--
  shift right arithmetically by another BitVec expression. For constant shifts there exists a `BVUnop`.
  -/
  | arithShiftRight (lhs : GenBVExpr m) (rhs : GenBVExpr n) : GenBVExpr m
  | zeroExtend (v : Nat) (expr : GenBVExpr w) : GenBVExpr v
  | truncate (v : Nat) (expr : GenBVExpr w) : GenBVExpr v

namespace GenBVExpr

def toString : GenBVExpr w → String
  | .var idx => s!"var{idx}"
  | .const val => ToString.toString val
  | .extract start len expr => s!"{expr.toString}[{start}, {len}]"
  | .bin lhs op rhs => s!"({lhs.toString} {op.toString} {rhs.toString})"
  | .un op operand => s!"({op.toString} {toString operand})"
  | .append lhs rhs _ => s!"({toString lhs} ++ {toString rhs})"
  | .replicate n expr _ => s!"(replicate {n} {toString expr})"
  | .shiftLeft lhs rhs => s!"({lhs.toString} << {rhs.toString})"
  | .shiftRight lhs rhs => s!"({lhs.toString} >> {rhs.toString})"
  | .arithShiftRight lhs rhs => s!"({lhs.toString} >>a {rhs.toString})"
  | .zeroExtend v expr => s!"(zeroExtend {v} {toString expr}})"
  | .truncate v expr => s!"(truncate {v} {toString expr}})"

instance : ToString (GenBVExpr w) := ⟨toString⟩

/--
The semantics for `BVExpr`.
-/
def eval (assign : BVExpr.Assignment) : GenBVExpr w → BitVec w
  | .var idx =>
    let packedBv := assign.get idx
    /-
    This formulation improves performance, as in a well formed expression the condition always holds
    so there is no need for the more involved `BitVec.truncate` logic.
    -/
    if h : packedBv.w = w then
      h ▸ packedBv.bv
    else
      packedBv.bv.truncate w
  | .const val => val
  | .extract start len expr => BitVec.extractLsb' start len (eval assign expr)
  | .bin lhs op rhs => op.eval (eval assign lhs) (eval assign rhs)
  | .un op operand => op.eval (eval assign operand)
  | .append lhs rhs h => h ▸ ((eval assign lhs) ++ (eval assign rhs))
  | .replicate n expr h => h ▸ (BitVec.replicate n (eval assign expr))
  | .shiftLeft lhs rhs => (eval assign lhs) <<< (eval assign rhs)
  | .shiftRight lhs rhs => (eval assign lhs) >>> (eval assign rhs)
  | .arithShiftRight lhs rhs => BitVec.sshiftRight' (eval assign lhs) (eval assign rhs)
  | .zeroExtend n expr => BitVec.zeroExtend n (eval assign expr)
  | .truncate n expr => BitVec.truncate n (eval assign expr)
end GenBVExpr

inductive GenBVPred where
  /--
  A binary predicate on `GenBVExpr`.
  -/
  | bin (lhs : GenBVExpr w) (op : BVBinPred) (rhs : GenBVExpr w)
  /--
  Getting a constant LSB from a `BitVec`.
  -/
  | getLsbD (expr : GenBVExpr w) (idx : Nat)

namespace GenBVPred

def toString : GenBVPred → String
  | bin lhs op rhs => s!"({lhs.toString} {op.toString} {rhs.toString})"
  | getLsbD expr idx => s!"{expr.toString}[{idx}]"

instance : ToString GenBVPred := ⟨toString⟩

/--
The semantics for `BVPred`.
-/
def eval (assign : BVExpr.Assignment) : GenBVPred → Bool
  | bin lhs op rhs => op.eval (lhs.eval assign) (rhs.eval assign)
  | getLsbD expr idx => (expr.eval assign).getLsbD idx

end GenBVPred

abbrev GenBVLogicalExpr := BoolExpr GenBVPred

namespace GenBVLogicalExpr
/--
The semantics of boolean problems involving BitVec predicates as atoms.
-/
def eval (assign : BVExpr.Assignment) (expr : GenBVLogicalExpr) : Bool :=
  BoolExpr.eval (·.eval assign) expr

end GenBVLogicalExpr

instance : BEq BVExpr.PackedBitVec where
  beq a b := if h : a.w = b.w then
                let b' := h ▸ b.bv
                a.bv == b'
              else
                false

instance : Hashable BVExpr.PackedBitVec where
  hash pbv := hash pbv.bv

structure BVExprWrapper where
  width : Nat
  bvExpr: GenBVExpr width

structure ParsedBVExprState where
  maxFreeVarId : Nat
  numSymVars :  Nat
  freeVarToBVExpr : Std.HashMap String BVExprWrapper
  BVExprIdToFreeVar : Std.HashMap Nat String
  originalWidth : Nat
  symVarToVal : Std.HashMap Nat BVExpr.PackedBitVec
  symVarToDisplayName : Std.HashMap Nat String
  valToSymVar : Std.HashMap BVExpr.PackedBitVec Nat


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
  default := {bvExpr := GenBVExpr.const (BitVec.ofNat 0 0), width := 0}

instance : Inhabited ParsedBVExprState where
  default := { maxFreeVarId := 0
             , numSymVars := 0, originalWidth := 32
             , BVExprIdToFreeVar := {}, symVarToVal := {}
             , symVarToDisplayName := {}, freeVarToBVExpr := {}, valToSymVar:= {}}

def printParsedBVExprState (s: ParsedBVExprState) :=
    s!"ParsedBVExprState:\n" ++
    s!"  maxFreeVarId: {s.maxFreeVarId}\n" ++
    s!"  numSymVars: {s.numSymVars}\n" ++
    s!"  freeVarToBVExpr: {s.freeVarToBVExpr}\n" ++
    s!"  BVExprIdToFreeVar: {s.BVExprIdToFreeVar}\n" ++
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
  inputVars : Std.HashMap Nat String

structure ParsedBVLogicalExpr where
  lhs: ParsedBVExpr
  rhs: ParsedBVExpr
  bvLogicalExpr: GenBVLogicalExpr
  state: ParsedBVExprState


abbrev ParseBVExprM := StateRefT ParsedBVExprState MetaM

def changeBVExprWidth (bvExpr: GenBVExpr w) (target: Nat) : GenBVExpr target := Id.run do
  if h : w = target then
    return (h ▸ bvExpr)

  match bvExpr with
  | .var idx => (GenBVExpr.var idx : GenBVExpr target)
  | .const val => GenBVExpr.const (val.signExtend target)
  | .extract start len expr => GenBVExpr.extract start target (changeBVExprWidth expr (start + target))
  | .bin lhs op rhs => GenBVExpr.bin (changeBVExprWidth lhs target) op (changeBVExprWidth rhs target)
  | .un op operand => GenBVExpr.un op (changeBVExprWidth operand target)
  | .shiftLeft lhs rhs =>  GenBVExpr.shiftLeft (changeBVExprWidth lhs target)  (changeBVExprWidth rhs target)
  | .shiftRight lhs rhs =>  GenBVExpr.shiftRight (changeBVExprWidth lhs target) (changeBVExprWidth rhs target)
  | .arithShiftRight lhs rhs => GenBVExpr.arithShiftRight (changeBVExprWidth lhs target) (changeBVExprWidth rhs target)
  | _ => GenBVExpr.const (BitVec.zero target) -- TODO: How to handle zeroextend, trunc, ?

def changeBVLogicalExprWidth (bvLogicalExpr: GenBVLogicalExpr) (target: Nat): GenBVLogicalExpr :=
  match bvLogicalExpr with
  | .literal (GenBVPred.bin lhs op rhs) => BoolExpr.literal (GenBVPred.bin (changeBVExprWidth lhs target) op (changeBVExprWidth rhs target))
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
    | bvExpr {w} (bvExpr : GenBVExpr w) : SubstitutionValue
    | packedBV  (bv: BVExpr.PackedBitVec) : SubstitutionValue

instance : Inhabited SubstitutionValue where
  default := SubstitutionValue.packedBV default

def bvExprToSubstitutionValue (map: Std.HashMap Nat (GenBVExpr w)) : Std.HashMap Nat SubstitutionValue :=
      Std.HashMap.ofList (List.map (fun item => (item.fst, SubstitutionValue.bvExpr item.snd)) map.toList)

def packedBitVecToSubstitutionValue (map: Std.HashMap Nat BVExpr.PackedBitVec) : Std.HashMap Nat SubstitutionValue :=
  Std.HashMap.ofList (List.map (fun item => (item.fst, SubstitutionValue.packedBV item.snd)) map.toList)

def substituteBVExpr (bvExpr: GenBVExpr w) (assignment: Std.HashMap Nat SubstitutionValue) : GenBVExpr w :=
    match bvExpr with
    | .var idx =>
        let value := assignment[idx]!
        match value with
        | .bvExpr (w := wbv) bv =>
          if h : w = wbv
          then h ▸ bv
          else GenBVExpr.extract 0 w bv
        | .packedBV packedBitVec =>  GenBVExpr.const (BitVec.ofNat w packedBitVec.bv.toNat)
    | .bin lhs op rhs =>
        GenBVExpr.bin (substituteBVExpr lhs assignment) op (substituteBVExpr rhs assignment)
    | .un op operand =>
        GenBVExpr.un op (substituteBVExpr operand assignment)
    | .shiftLeft lhs rhs =>
        GenBVExpr.shiftLeft (substituteBVExpr lhs assignment) (substituteBVExpr rhs assignment)
    | .shiftRight lhs rhs =>
        GenBVExpr.shiftRight (substituteBVExpr lhs assignment) (substituteBVExpr rhs assignment)
    | .arithShiftRight lhs rhs =>
        GenBVExpr.arithShiftRight (substituteBVExpr lhs assignment) (substituteBVExpr rhs assignment)
    | .zeroExtend w expr =>
        GenBVExpr.zeroExtend w (substituteBVExpr expr assignment)
    | .truncate w expr =>
        GenBVExpr.truncate w (substituteBVExpr expr assignment)
    | .extract start len expr =>
        GenBVExpr.extract start len (substituteBVExpr expr assignment)
    | e => e

def substitute  (bvLogicalExpr: GenBVLogicalExpr) (assignment: Std.HashMap Nat SubstitutionValue) :
          GenBVLogicalExpr :=
  match bvLogicalExpr with
  | .literal (GenBVPred.bin lhs op rhs) => BoolExpr.literal (GenBVPred.bin (substituteBVExpr lhs assignment) op (substituteBVExpr rhs assignment))
  | .not boolExpr =>
      BoolExpr.not (substitute boolExpr assignment)
  | .gate op lhs rhs =>
      BoolExpr.gate op (substitute lhs assignment) (substitute rhs assignment)
  | .ite constVar auxVar op3 =>
      BoolExpr.ite (substitute constVar assignment) (substitute auxVar assignment) (substitute op3 assignment)
  | _ => bvLogicalExpr


def sameBothSides (bvLogicalExpr : BVLogicalExpr) : Bool :=
    match bvLogicalExpr with
  | .literal (BVPred.bin lhs _ rhs) => lhs == rhs
  | _ => false

/-
This function expects that targetWidth >= w
-/
def evalBVExpr (assignments : Std.HashMap Nat BVExpr.PackedBitVec) (targetWidth: Nat) (expr: GenBVExpr w) : BitVec targetWidth :=
  let newWidthExpr := changeBVExprWidth expr targetWidth
  let substitutedBvExpr := substituteBVExpr newWidthExpr (packedBitVecToSubstitutionValue assignments)

  let h : 0 < assignments.valuesArray.size := sorry
  let rArrayAssignments : BVExpr.Assignment  := RArray.ofArray assignments.valuesArray h
  GenBVExpr.eval rArrayAssignments substitutedBvExpr


def evalBVLogicalExpr (assignments : Std.HashMap Nat BVExpr.PackedBitVec) (targetWidth: Nat) (expr: GenBVLogicalExpr) : Bool :=
  let newWidthExpr := changeBVLogicalExprWidth expr targetWidth
  let substitutedBvExpr := substitute newWidthExpr (packedBitVecToSubstitutionValue assignments)

  let h : 0 < assignments.valuesArray.size := sorry
  let rArrayAssignments : BVExpr.Assignment  := RArray.ofArray assignments.valuesArray h
  GenBVLogicalExpr.eval rArrayAssignments substitutedBvExpr


def add (op1 : GenBVExpr w) (op2 : GenBVExpr w) : GenBVExpr w :=
  GenBVExpr.bin op1 BVBinOp.add op2

def negate (bvExpr: GenBVExpr w) : GenBVExpr w :=
  -- Two's complement value = 1 + Not(Var)
  GenBVExpr.bin (GenBVExpr.const (BitVec.ofNat w 1)) BVBinOp.add (GenBVExpr.un BVUnOp.not bvExpr)

def subtract (op1 : GenBVExpr w) (op2 : GenBVExpr w) : GenBVExpr w :=
  add op1 (negate op2)

def multiply (op1 : GenBVExpr w) (op2 : GenBVExpr w) : GenBVExpr w :=
  GenBVExpr.bin op1 BVBinOp.mul op2

def udiv (op1 : GenBVExpr w) (op2 : GenBVExpr w) : GenBVExpr w :=
  GenBVExpr.bin op1 BVBinOp.udiv op2

def umod  (op1 : GenBVExpr w) (op2 : GenBVExpr w) : GenBVExpr w :=
  GenBVExpr.bin op1 BVBinOp.umod op2

def and (op1 : GenBVExpr w) (op2: GenBVExpr w) : GenBVExpr w :=
  GenBVExpr.bin op1 BVBinOp.and op2

def or (op1 : GenBVExpr w) (op2: GenBVExpr w) : GenBVExpr w :=
  GenBVExpr.bin op1 BVBinOp.or op2

def xor (op1 : GenBVExpr w) (op2: GenBVExpr w) : GenBVExpr w :=
  GenBVExpr.bin op1 BVBinOp.xor op2

def shiftLeft (op1 : GenBVExpr w) (op2: GenBVExpr w) : GenBVExpr w :=
  GenBVExpr.shiftLeft op1 op2

def shiftRight (op1 : GenBVExpr w) (op2: GenBVExpr w) : GenBVExpr w :=
  GenBVExpr.shiftRight op1 op2

def arithShiftRight (op1 : GenBVExpr w) (op2: GenBVExpr w) : GenBVExpr w :=
  GenBVExpr.arithShiftRight op1 op2

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
                                                                , symVarToDisplayName := currState.symVarToDisplayName.insert newId s!"C{numSymVars + 1}"}
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
            let userFacingName := ((← getLCtx).get! name).userName.getRoot.toString

            let existingVar? := currState.freeVarToBVExpr[userFacingName]?
            match existingVar? with
            | some val => return val
            | none =>
                let newId := currState.maxFreeVarId + 1
                let newExpr : GenBVExpr targetWidth :=  GenBVExpr.var newId
                let newWrappedExpr : BVExprWrapper := {bvExpr := newExpr, width := targetWidth}

                let updatedState : ParsedBVExprState :=  { currState with
                                                         maxFreeVarId := newId
                                                         , freeVarToBVExpr := currState.freeVarToBVExpr.insert userFacingName newWrappedExpr
                                                         , BVExprIdToFreeVar := currState.BVExprIdToFreeVar.insert newId userFacingName
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
    | BitVec.zeroExtend _ nExpr vExpr =>
      logInfo m! "matched zero extend: {e}"
      let n ← getNatValue? nExpr
      let v ← getBitVecValue? vExpr
      return ⟨n, BitVec.zeroExtend n v.snd⟩
    | BitVec.truncate _ nExpr vExpr =>
      logInfo m! "matched truncate: {e}"
      let n ← getNatValue? nExpr
      let v ← getBitVecValue? vExpr
      return ⟨n, BitVec.truncate n v.snd⟩
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
                                              , symVarToDisplayName := currState.symVarToDisplayName.insert newId s!"C{numSymVars + 1}"}
      set updatedState
      return some {bvExpr := newExpr, width := targetWidth}
    | some var => let newExpr : GenBVExpr targetWidth := GenBVExpr.var var
                  return some {bvExpr := newExpr, width := targetWidth}



def parseExprs (lhsExpr rhsExpr : Expr) (targetWidth : Nat): ParseBVExprM (Option ParsedBVLogicalExpr) := do
  let some lhsRes ← toBVExpr lhsExpr targetWidth | throwError "Could not extract lhs: {lhsExpr}"

  let state ← get
  let lhs: ParsedBVExpr := {bvExpr := lhsRes.bvExpr, width := lhsRes.width, symVars := state.symVarToVal, inputVars := state.BVExprIdToFreeVar}

  let some rhsRes ← toBVExpr rhsExpr targetWidth | throwError "Could not extract rhs: {rhsExpr}"
  let state ← get

  let rhsInputVars := state.BVExprIdToFreeVar.filter fun k _ => !lhs.inputVars.contains k
  let rhsSymVars := state.symVarToVal.filter fun k _ => !lhs.symVars.contains k

  let rhs: ParsedBVExpr := {bvExpr := rhsRes.bvExpr, width := rhsRes.width, symVars := rhsSymVars, inputVars := rhsInputVars}

  if h : lhsRes.width = rhsRes.width then
    let rhsExpr := h ▸ rhsRes.bvExpr
    let bvLogicalExpr := BoolExpr.literal (GenBVPred.bin lhsRes.bvExpr BVBinPred.eq rhsExpr)
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
    let cfg: BVDecideConfig := {timeout := 60}

    IO.FS.withTempFile fun _ lratFile => do
      let ctx ← BVDecide.Frontend.TacticContext.new lratFile cfg
      let entry ← IO.lazyPure (fun _ => bvExpr.bitblast)

      let (cnf, map) ← IO.lazyPure (fun _ =>
            let (entry, map) := entry.relabelNat'
            let cnf := AIG.toCNF entry
            (cnf, map))

      let res ← runExternal cnf ctx.solver ctx.lratPath
          (trimProofs := ctx.config.trimProofs)
          (timeout := ctx.config.timeout)
          (binaryProofs := ctx.config.binaryProofs)

      match res with
      | .ok proof =>
        withTraceNode `Generalize (fun _ => return "Verified proof") do
            let valid := BVDecide.Reflect.verifyBVExpr bvExpr proof
            if !valid then
                throwError m! "Received invalid proof from SAT"
            pure ()
        return none
      | .error assignment =>
        let equations := reconstructAssignment' map assignment entry.aig.decls.size
        return .some equations


---- Test Solver function ----
def simpleArith : GenBVLogicalExpr :=
  let x := GenBVExpr.const (BitVec.ofNat 5 2)
  let y := GenBVExpr.const (BitVec.ofNat 5 4)
  let z : GenBVExpr 5 := GenBVExpr.var 0
  let sum : GenBVExpr 5 := GenBVExpr.bin x BVBinOp.add z
  BoolExpr.literal (GenBVPred.bin sum BVBinPred.eq y)

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

def addConstraints (expr: GenBVLogicalExpr) (constraints: List GenBVLogicalExpr) (op: Gate := Gate.and) : GenBVLogicalExpr :=
      match constraints with
      | [] => expr
      | x::xs =>
          match expr with
          | BoolExpr.const _ => addConstraints x xs op
          | _ => addConstraints (BoolExpr.gate op expr x) xs op

def getIdentityAndAbsorptionConstraints (bvLogicalExpr: GenBVLogicalExpr) (symVars : Std.HashSet Nat) : List GenBVLogicalExpr :=
      match bvLogicalExpr with
      | .literal (GenBVPred.bin lhs _ rhs) => (getBVExprConstraints lhs) ++ (getBVExprConstraints rhs)
      | .not boolExpr => getIdentityAndAbsorptionConstraints boolExpr symVars
      | .gate _ lhs rhs => (getIdentityAndAbsorptionConstraints lhs symVars) ++ (getIdentityAndAbsorptionConstraints rhs symVars)
      | .ite constVar auxVar op3 =>
          (getIdentityAndAbsorptionConstraints constVar symVars) ++ (getIdentityAndAbsorptionConstraints auxVar symVars) ++ (getIdentityAndAbsorptionConstraints op3 symVars)
      | _ => []

      where
        getBVExprConstraints {w} (bvExpr : GenBVExpr w) : List GenBVLogicalExpr := Id.run do
                match bvExpr with
                | .shiftRight lhs rhs | .shiftLeft lhs rhs | .arithShiftRight lhs rhs =>
                      match (lhs, rhs) with
                      | (GenBVExpr.var lhsId, GenBVExpr.var rhsId) =>
                          let mut constraints := []

                          if symVars.contains lhsId then
                            constraints := getLhsShiftConstraints lhs ++ constraints

                          if symVars.contains rhsId then
                            constraints := getRhsShiftConstraints rhs ++ constraints
                          pure constraints
                      | (GenBVExpr.var lhsId, _) =>
                          if !symVars.contains lhsId then
                            getBVExprConstraints rhs
                          else
                            (getLhsShiftConstraints lhs) ++ (getBVExprConstraints rhs)
                      | (_, GenBVExpr.var rhsId) =>
                          if !symVars.contains rhsId then
                            getBVExprConstraints lhs
                          else
                          (getBVExprConstraints lhs)  ++ (getRhsShiftConstraints rhs)
                      | _ => ((getBVExprConstraints lhs) ++ (getBVExprConstraints rhs))
                | .bin lhs op rhs  =>
                      match (lhs, rhs) with
                      | (GenBVExpr.var lhsId, GenBVExpr.var rhsId) =>
                          let mut constraints := []

                          if symVars.contains lhsId then
                            constraints := getBitwiseConstraints lhs op ++ constraints

                          if symVars.contains rhsId then
                            constraints := getBitwiseConstraints rhs op ++ constraints
                          pure constraints
                      | (GenBVExpr.var lhsId, _) =>
                          if !symVars.contains lhsId then
                            getBVExprConstraints rhs
                          else
                            (getBitwiseConstraints lhs op) ++ (getBVExprConstraints rhs)
                      | (_, GenBVExpr.var rhsId) =>
                          if !symVars.contains rhsId then
                            getBVExprConstraints lhs
                          else
                         (getBVExprConstraints lhs)  ++ (getBitwiseConstraints rhs op)
                      | _ => ((getBVExprConstraints lhs) ++ (getBVExprConstraints rhs))
                | .un _ operand =>
                      getBVExprConstraints operand
                | _ =>  []

        getLhsShiftConstraints {w} (bvExpr : GenBVExpr w) : List GenBVLogicalExpr :=
          let neqZero := BoolExpr.not (BoolExpr.literal (GenBVPred.bin bvExpr BVBinPred.eq (GenBVExpr.const ((BitVec.ofNat w 0)))))
          [neqZero]

        getRhsShiftConstraints {w} (bvExpr : GenBVExpr w) : List GenBVLogicalExpr :=
          let ltWidth := BoolExpr.literal (GenBVPred.bin bvExpr BVBinPred.ult (GenBVExpr.const (BitVec.ofNat w w)))
          let neqZero := BoolExpr.not (BoolExpr.literal (GenBVPred.bin bvExpr BVBinPred.eq (GenBVExpr.const ((BitVec.ofNat w 0)))))

          [ltWidth, neqZero]

        getBitwiseConstraints {w} (bvExpr: GenBVExpr w) (op : BVBinOp): List GenBVLogicalExpr :=
            let neqZero := BoolExpr.not (BoolExpr.literal (GenBVPred.bin bvExpr BVBinPred.eq (GenBVExpr.const (BitVec.ofNat w 0))))
            let neqAllOnes := BoolExpr.not (BoolExpr.literal (GenBVPred.bin bvExpr BVBinPred.eq (GenBVExpr.const (BitVec.allOnes w))))

            match op with
            | BVBinOp.xor => [neqZero]
            | BVBinOp.or | BVBinOp.and => [neqZero, neqAllOnes]
            | _ => []


partial def existsForAll (origExpr: GenBVLogicalExpr) (existsVars: List Nat) (forAllVars: List Nat)  (numExamples: Nat := 1):
                  TermElabM (List (Std.HashMap Nat BVExpr.PackedBitVec)) := do
    let rec constantsSynthesis (bvExpr: GenBVLogicalExpr) (existsVars: List Nat) (forAllVars: List Nat)
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
    let identityAndAbsorptionConstraints := getIdentityAndAbsorptionConstraints origExpr (Std.HashSet.ofList existsVars)
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

           let results ← existsForAll bvExpr state.symVarToVal.keys state.BVExprIdToFreeVar.keys 3

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
#reducewidth (x ||| 145#32) &&& 177#32 ^^^ 153#32 = x &&& 32#32 ||| 8#32  : 8
#reducewidth 1#32 <<< (31#32 - x) = BitVec.ofInt 32 (-2147483648) >>> x : 8
#reducewidth 8#32 - x &&& 7#32 = 0#32 - x &&& 7#32 : 4

#reducewidth BitVec.sshiftRight' (x &&& ((BitVec.ofInt 32 (-1)) <<< (32 - y))) (BitVec.ofInt 32 32 - y) = BitVec.sshiftRight' x (BitVec.ofInt 32 32 - y) : 8
#reducewidth x <<< 6#32 <<< 28#32 = 0#32 : 4


partial def deductiveSearch (expr: GenBVExpr w) (constants: Std.HashMap Nat BVExpr.PackedBitVec) (target: BVExpr.PackedBitVec) (depth: Nat) (parent: Nat) :
                      TermElabM ( List (GenBVExpr w)) := do

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
            let mut res : List (GenBVExpr w) := []

            for (constId, constVal) in constants.toArray do
              let newVar := BVExpr.var constId

              if constVal == target then
                res := newVar :: res
                continue

              if constId == parent then -- Avoid runaway expressions
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
                let addRes ← deductiveSearch expr constants {bv := targetBv - constVal.bv} (depth-1) constId
                res := res ++ addRes.map (λ resExpr => BVExpr.bin newVar BVBinOp.add resExpr)

                -- C - X = Target
                let subRes ← deductiveSearch expr constants {bv := constVal.bv - targetBv} (depth-1) constId
                res := res ++ subRes.map (λ resExpr => BVExpr.bin newVar BVBinOp.add (negate resExpr))

                -- X - C = Target
                let subRes' ← deductiveSearch expr constants {bv := targetBv + constVal.bv}  (depth-1) constId
                res := res ++ subRes'.map (λ resExpr => BVExpr.bin (resExpr) BVBinOp.add (negate newVar))

                -- X * C = Target
                if (BitVec.srem targetBv constVal.bv) == 0 && (BitVec.sdiv targetBv constVal.bv != 0) then
                  let mulRes ← deductiveSearch expr constants {bv := BitVec.sdiv targetBv constVal.bv} (depth - 1) constId
                  res := res ++ mulRes.map (λ resExpr => BVExpr.bin newVar BVBinOp.mul resExpr)

                -- C / X = Target
                if targetBv != 0 && (BitVec.umod constVal.bv targetBv) == 0 then
                  let divRes ← deductiveSearch expr constants {bv := BitVec.udiv constVal.bv targetBv} (depth - 1) constId
                  res := res ++ divRes.map (λ resExpr => BVExpr.bin newVar BVBinOp.udiv resExpr)

              else
                    throwError m! "Width mismatch for expr : {expr} and target: {target}"
            return res



def updateConstantValues (bvExpr: ParsedBVExpr) (assignments: Std.HashMap Nat BVExpr.PackedBitVec)
             : ParsedBVExpr := {bvExpr with symVars := assignments.filter (λ id _ => bvExpr.symVars.contains id)}



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
  let targetExpr := (BoolExpr.not bvExpr)
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

def pruneEquivalentBVExprs (expressions: List (GenBVExpr w)) : TermElabM (List (GenBVExpr w)) := do
  withTraceNode `Generalize (fun _ => return "Pruned equivalent bvExprs") do
    let mut pruned : List (GenBVExpr w) := []

    for expr in expressions do
      if pruned.isEmpty then
        pruned := expr :: pruned
        continue

      let newConstraints := pruned.map (fun f =>  BoolExpr.not (BoolExpr.literal (BVPred.bin f BVBinPred.eq expr)))
      let subsumeCheckExpr :=  addConstraints (BoolExpr.const True) newConstraints

      if let some _ ← solve subsumeCheckExpr then
        pruned := expr :: pruned

    logInfo m! "Removed {expressions.length - pruned.length} expressions after pruning"

    pure pruned

def pruneEquivalentBVLogicalExprs(expressions : List BVLogicalExpr): TermElabM (List BVLogicalExpr) := do
  withTraceNode `Generalize (fun _ => return "Pruned equivalent bvLogicalExprs") do
    let mut pruned: List BVLogicalExpr:= []
    for expr in expressions do
      if pruned.isEmpty then
        pruned := expr :: pruned
        continue

      let newConstraints := pruned.map (fun f =>  BoolExpr.not (BoolExpr.gate Gate.beq f expr))
      let subsumeCheckExpr :=  addConstraints (BoolExpr.const True) newConstraints

      if let some _ ← solve subsumeCheckExpr then
        pruned := expr :: pruned

    logInfo m! "Removed {expressions.length - pruned.length} expressions after pruning"
    pure pruned

structure PreconditionSynthesisCacheValue where
  positiveExampleValues : List BVExpr.PackedBitVec
  negativeExampleValues : List BVExpr.PackedBitVec

instance : ToString PreconditionSynthesisCacheValue where
  toString val :=
    s! "⟨positiveExampleValues := {val.positiveExampleValues}, negativeExampleValues := {val.negativeExampleValues}⟩"

structure GeneralizerState where
  startTime: Nat
  timeout : Nat
  processingWidth : Nat
  targetWidth : Nat
  widthId: Nat
  parsedBVLogicalExpr : ParsedBVLogicalExpr
  needsPreconditionsExprs : List BVLogicalExpr
  visitedSubstitutions : Std.HashSet BVLogicalExpr
  constantExprsEnumerationCache : Std.HashMap (GenBVExpr processingWidth) BVExpr.PackedBitVec

abbrev GeneralizerStateM := StateRefT GeneralizerState TermElabM

def zero (w: Nat) := BVExpr.const (BitVec.ofNat w 0)
def one (w: Nat) := BVExpr.const (BitVec.ofNat w 1)
def minusOne (w: Nat) := BVExpr.const (BitVec.ofInt w (-1))

def eqToZero (expr: GenBVExpr w) : BVLogicalExpr :=
  BoolExpr.literal (BVPred.bin expr BVBinPred.eq (zero w))

def positive (expr: GenBVExpr w) (widthId : Nat) : BVLogicalExpr :=
  let shiftDistance : GenBVExpr w :=  subtract (BVExpr.var widthId) (one w)
  let signVal := BVExpr.shiftLeft (one w) shiftDistance
  BoolExpr.literal (BVPred.bin expr BVBinPred.ult signVal) --- It's positive if `expr <u 2 ^ (w - 1)`

def strictlyGTZero  (expr: GenBVExpr w) (widthId : Nat)  : BVLogicalExpr :=
  BoolExpr.gate  Gate.and (BoolExpr.literal (BVPred.bin (zero w) BVBinPred.ult expr)) (positive expr widthId)

def gteZero (expr: GenBVExpr w) (widthId : Nat)  : BVLogicalExpr :=
  positive expr widthId

def negative (expr: GenBVExpr w) (widthId : Nat) : BVLogicalExpr :=
  BoolExpr.not (positive expr widthId)

def strictlyLTZero (expr: GenBVExpr w) (widthId : Nat) : BVLogicalExpr :=
  negative expr widthId

def lteZero (expr: GenBVExpr w) (widthId : Nat) : BVLogicalExpr :=
  BoolExpr.gate Gate.or (eqToZero expr) (negative expr widthId)

def checkTimeout : GeneralizerStateM Unit := do
  let state ← get
  let currentTime ← Core.liftIOCore IO.monoMsNow
  let elapsedTime := currentTime - state.startTime

  trace[Generalize] m! "Elapsed time: {elapsedTime/1000}s"
  if elapsedTime >= state.timeout then
      throwError m! "Synthesis Timeout Failure: Exceeded timeout of {state.timeout/1000}s"

def filterCandidatePredicates  (bvLogicalExpr: BVLogicalExpr) (preconditionCandidates visited: Std.HashSet BVLogicalExpr) : GeneralizerStateM (List BVLogicalExpr) :=
  withTraceNode `Generalize (fun _ => return "Filtered out invalid expression sketches") do
    let state ← get
    let widthId := state.widthId
    let bitwidth := state.processingWidth

    let mut res : List BVLogicalExpr := []
    -- let mut currentCandidates := preconditionCandidates
    -- if numConjunctions >= 1 then
    --   let combinations := generateCombinations numConjunctions currentCandidates.toList
    --   currentCandidates := Std.HashSet.ofList (combinations.map (λ comb => addConstraints (BoolExpr.const True) comb))
    let widthConstraint : BVLogicalExpr := BoolExpr.literal (BVPred.bin (BVExpr.var widthId) BVBinPred.eq (BVExpr.const (BitVec.ofNat bitwidth bitwidth)))

    let mut numInvocations := 0
    let mut currentCandidates := preconditionCandidates.filter (λ cand => !visited.contains cand)
    logInfo m! "Originally processing {currentCandidates.size} candidates"

    -- Progressive filtering implementation
    while !currentCandidates.isEmpty do
      let expressionsConstraints : BVLogicalExpr := addConstraints (BoolExpr.const False) currentCandidates.toList Gate.or
      let expr := BoolExpr.gate Gate.and (addConstraints expressionsConstraints [widthConstraint]) (BoolExpr.not bvLogicalExpr)

      let mut newCandidates : Std.HashSet BVLogicalExpr := Std.HashSet.emptyWithCapacity
      numInvocations := numInvocations + 1
      match (← solve expr) with
      | none => break
      | some assignment =>
          newCandidates ← withTraceNode `Generalize (fun _ => return "Evaluated expressions for filtering") do
            let mut res : Std.HashSet BVLogicalExpr := Std.HashSet.emptyWithCapacity
            for candidate in currentCandidates do
              let widthSubstitutedCandidate := substitute candidate (bvExprToSubstitutionValue (Std.HashMap.ofList [(widthId, BVExpr.const (BitVec.ofNat bitwidth bitwidth))]))
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
          let constVar : GenBVExpr w := BVExpr.var const
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
    (ops : List (GenBVExpr w → GenBVExpr w → GenBVExpr w)) : GeneralizerStateM (Std.HashMap (GenBVExpr w)  PreconditionSynthesisCacheValue) := do
    let mut currentCache := Std.HashMap.emptyWithCapacity
    let mut observationalEquivFilter : Std.HashSet String := Std.HashSet.emptyWithCapacity

    let evaluateCombinations (combos :  List (BVExpr.PackedBitVec × BVExpr.PackedBitVec)) (examples: List (HashMap Nat BVExpr.PackedBitVec))
            (op : GenBVExpr w → GenBVExpr w → GenBVExpr w) : GeneralizerStateM (List (BitVec w)) := do
          let mut res : List (BitVec w) := []
          let mut index := 0
          for (lhs, rhs) in combos do
            let h : lhs.w = w := sorry
            let h' : rhs.w = w := sorry
            if h : lhs.w = w ∧ rhs.w = w then
              res := (evalBVExpr examples[index]! w (op  (BVExpr.const (h.left ▸ lhs.bv)) (BVExpr.const (h.right ▸ rhs.bv)))) :: res
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

def generatePreconditions (bvLogicalExpr: BVLogicalExpr) (positiveExamples negativeExamples: List (Std.HashMap Nat BVExpr.PackedBitVec))
              (numConjunctions: Nat) : GeneralizerStateM (Option BVLogicalExpr) := do

    let state ← get
    let widthId := state.widthId
    let bitwidth := state.processingWidth

    let specialConstants : Std.HashMap (GenBVExpr bitwidth) BVExpr.PackedBitVec := Std.HashMap.ofList [
        ((one bitwidth), {bv := BitVec.ofNat bitwidth 1}),
        ((minusOne bitwidth), {bv := BitVec.ofInt bitwidth (-1)}),
        (BVExpr.var widthId, {bv := BitVec.ofNat bitwidth bitwidth})]

    let validCandidates ← withTraceNode `Generalize (fun _ => return "Attempted to generate valid preconditions") do
      let mut preconditionCandidates : Std.HashSet BVLogicalExpr := Std.HashSet.emptyWithCapacity
      let synthesisComponents : Std.HashMap (GenBVExpr bitwidth)  PreconditionSynthesisCacheValue := getPreconditionSynthesisComponents positiveExamples negativeExamples specialConstants

      -- Check for power of 2: const & (const - 1) == 0
      for const in positiveExamples[0]!.keys do
        let bvExprVar := BVExpr.var const
        let powerOf2Expr :=  BVExpr.bin bvExprVar BVBinOp.and (BVExpr.bin bvExprVar BVBinOp.add (minusOne bitwidth))
        let powerOfTwoResults := positiveExamples.map (λ pos => evalBVExpr pos bitwidth powerOf2Expr)

        if powerOfTwoResults.any (λ val => val == 0) then
          let powerOf2 := BoolExpr.literal (BVPred.bin powerOf2Expr BVBinPred.eq (zero bitwidth))
          preconditionCandidates := preconditionCandidates.insert powerOf2

      let mut previousLevelCache : Std.HashMap (GenBVExpr bitwidth) PreconditionSynthesisCacheValue := synthesisComponents

      let numVariables := positiveExamples[0]!.keys.length + 1 -- Add 1 for the width ID
      let ops : List (GenBVExpr bitwidth -> GenBVExpr bitwidth -> GenBVExpr bitwidth):= [add, subtract, multiply, and, or, xor, shiftLeft, shiftRight, arithShiftRight]

      let mut currentLevel := 0
      let mut validCandidates : List BVLogicalExpr := []
      let mut visited : Std.HashSet BVLogicalExpr := Std.HashSet.emptyWithCapacity

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

def lhsSketchEnumeration  (lhsSketch: GenBVExpr w) (inputVars: List Nat) (lhsSymVars rhsSymVars : Std.HashMap Nat BVExpr.PackedBitVec) : Std.HashMap Nat (List (GenBVExpr w)) := Id.run do
  let zero := BVExpr.const (BitVec.ofNat w 0)
  let one := BVExpr.const (BitVec.ofNat w 1 )
  let minusOne := BVExpr.const (BitVec.ofInt w (-1))

  let specialConstants := [zero, one, minusOne]
  let inputCombinations := productsList (List.replicate inputVars.length specialConstants)

  let lhsSymVarsAsBVExprs : List (GenBVExpr w):= lhsSymVars.keys.map (λ k => BVExpr.var k)
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
                            : TermElabM (Std.HashMap Nat (List (GenBVExpr w))) := do
      withTraceNode `Generalize (fun _ => return "Pruned expressions synthesis results") do
          let mut tempResults : Std.HashMap Nat (List (GenBVExpr w)) := Std.HashMap.emptyWithCapacity

          for (var, expressions) in exprSynthesisResults.toList do
              let mut prunedExprs ← pruneEquivalentBVExprs expressions
              tempResults := tempResults.insert var prunedExprs.reverse

          pure tempResults


def getCombinationWithNoPreconditions (exprSynthesisResults : Std.HashMap Nat (List (GenBVExpr processingWidth))) : GeneralizerStateM (Option BVLogicalExpr) := do
  withTraceNode `Generalize (fun _ => return "Checked if expressions require preconditions") do
    -- logInfo m! "Expression synthesis results : {exprSynthesisResults}"
    let combinations := productsList exprSynthesisResults.values
    let mut substitutions := []

    let state ← get
    let parsedBVLogicalExpr := state.parsedBVLogicalExpr
    let mut visited := state.visitedSubstitutions

    for combo in combinations do
      -- Substitute the generated expressions into the main one, so the constants on the RHS are expressed in terms of the left.
      let zippedCombo := Std.HashMap.ofList (List.zip parsedBVLogicalExpr.rhs.symVars.keys combo)
      let substitution := substitute parsedBVLogicalExpr.bvLogicalExpr (bvExprToSubstitutionValue zippedCombo)
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
                                          (ops: List (GenBVExpr w → GenBVExpr w → GenBVExpr w)) : GeneralizerStateM (Std.HashMap Nat (List (GenBVExpr w))) := do
    let zero := BitVec.ofNat w 0
    let one := BitVec.ofNat w 1
    let minusOne := BitVec.ofInt w (-1)

    let specialConstants : Std.HashMap (GenBVExpr w) BVExpr.PackedBitVec := Std.HashMap.ofList [
      (BVExpr.const one, {bv := one}),
      (BVExpr.const minusOne, {bv := minusOne})
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

      let packedBVExpr : BVExpr w := BVExpr.const (h' ▸ packedBV.bv)

      for (lhsVar, lhsVal) in allLhsVars.toArray do
        for op in ops do
          let evaluatedRes := evalBVExpr lhsSymVars w (op packedBVExpr lhsVar)

          let mut newExpr : BVExpr w := op (h ▸ bvExpr) lhsVar
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


def synthesizeWithNoPrecondition (constantAssignments : List (Std.HashMap Nat BVExpr.PackedBitVec)): GeneralizerStateM (Option BVLogicalExpr) :=  do
    let state ← get
    let parsedBVLogicalExpr := state.parsedBVLogicalExpr
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
          allLHSVars := allLHSVars.insert (BVExpr.var var) value
          allLHSVars := allLHSVars.insert (BVExpr.un BVUnOp.not ((BVExpr.var var))) {bv := BitVec.not (value.bv)}

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

def checkForPreconditions (constantAssignments : List (Std.HashMap Nat BVExpr.PackedBitVec)) (maxConjunctions: Nat)
                                                : GeneralizerStateM (Option BVLogicalExpr) := do
  let state ← get
  let parsedBVLogicalExpr := state.parsedBVLogicalExpr

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

def prettifyBVExpr (bvExpr : GenBVExpr w) (displayNames: Std.HashMap Nat String) : String :=
    match bvExpr with
    | .var idx => displayNames[idx]!
    | .const bv =>
       toString bv.toInt
    | .bin lhs BVBinOp.add (.bin  (BVExpr.const bv) BVBinOp.add (BVExpr.un BVUnOp.not rhs)) =>
      if bv.toInt == 1 then -- A subtraction
        s! "({prettifyBVExpr lhs displayNames} - {prettifyBVExpr rhs displayNames})"
      else
        s! "({prettifyBVExpr lhs displayNames} + ({prettifyBVExpr (BVExpr.const bv) displayNames} + {prettifyBVExpr (BVExpr.un BVUnOp.not rhs) displayNames}))"
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

def isGteZeroCheck (expr : BVLogicalExpr) : Bool :=
  match expr with
  | .literal (BVPred.bin _ BVBinPred.ult (BVExpr.shiftLeft (BVExpr.const bv) (BVExpr.bin (BVExpr.var _) BVBinOp.add (BVExpr.bin (BVExpr.const bv') BVBinOp.add (BVExpr.un BVUnOp.not (BVExpr.const bv'')))))) =>
          bv.toInt == 1 && bv'.toInt == 1 && bv''.toInt == 1
  | _ => false

def prettifyComparison (bvLogicalExpr : BVLogicalExpr) (displayNames: Std.HashMap Nat String)  : Option String := Id.run do
  let mut res : Option String := none
  match bvLogicalExpr with
  | .literal (BVPred.bin lhs BVBinPred.ult _) =>
    if isGteZeroCheck bvLogicalExpr then
      res := some s! "{prettifyBVExpr lhs displayNames} >= 0"
  | .gate Gate.and (BoolExpr.literal (BVPred.bin (BVExpr.const bv) BVBinPred.ult expr)) rhs =>
    if bv.toInt == 0 && isGteZeroCheck rhs then
      res := some s! "{prettifyBVExpr expr displayNames} > 0"
  | .not expr  =>
     if isGteZeroCheck expr then
      match expr with
      |  .literal (BVPred.bin lhs _ _) => res := some s! "{prettifyBVExpr lhs displayNames} < 0"
      | _ => return none
  | _ => return none

  res

def prettify (generalization: BVLogicalExpr) (displayNames: Std.HashMap Nat String) : String :=
  match (prettifyComparison generalization displayNames) with
  | some s => s
  | none =>
      match generalization with
      | .literal (BVPred.bin lhs op rhs) =>
          s! "{prettifyBVExpr lhs displayNames} {prettifyBVBinPred op} {prettifyBVExpr rhs displayNames}"
      | .not boolExpr =>
          s! "!({prettify boolExpr displayNames})"
      | .gate op lhs rhs =>
          s! "({prettify lhs displayNames}) {op.toString} ({prettify rhs displayNames})"
      | .ite cond positive _ =>
          s! "if {prettify cond displayNames} then {prettify positive displayNames} "
      | _ => generalization.toString

def generalize  (constantAssignments : List (Std.HashMap Nat BVExpr.PackedBitVec)) : GeneralizerStateM (Option BVLogicalExpr) := do
    let exprWithNoPrecondition  ← withTraceNode `Generalize (fun _ => return "Performed expression synthesis") do
        synthesizeWithNoPrecondition constantAssignments
    let maxConjunctions : ℕ := 1

    match exprWithNoPrecondition with
    | some generalized => return some generalized
    | none =>
              let state ← get
              if state.needsPreconditionsExprs.isEmpty then
                throwError m! "Could not synthesise constant expressions for {state.parsedBVLogicalExpr.bvLogicalExpr}"

              let preconditionRes ← withTraceNode `Generalize (fun _ => return "Attempted to generate weak precondition for all expression combos") do
                checkForPreconditions constantAssignments maxConjunctions

              match preconditionRes with
              | some expr => return some expr
              | none => return none
    -- TODO:  verify width independence

inductive GeneralizeContext where
  | Command : GeneralizeContext
  | Tactic (name : Name) : GeneralizeContext


def printAsTheorem (name: Name) (generalization: BVLogicalExpr) (displayNames: Std.HashMap Nat String) : String := Id.run do
  let params := displayNames.values.filter (λ n => n != "w")
  let mut res := s! "theorem {name}" ++ " {w} " ++ s! "({String.intercalate " " params} : BitVec w)"

  match generalization with
  | .ite cond positive _ => res := res ++ s! " (h: {prettify cond displayNames}) : {prettify positive displayNames}"
  | _ => res := res ++ s! " : {prettify generalization displayNames}"

  res := res ++ s! " := by sorry"
  pure res

def parseAndGeneralize (hExpr : Expr) (context: GeneralizeContext): TermElabM MessageData := do
    let targetWidth := 8
    let timeoutMs := 600000

    match_expr hExpr with
    | Eq _ lhsExpr rhsExpr =>
          let startTime ← Core.liftIOCore IO.monoMsNow

          -- Parse the input expression
          let initialState : ParsedBVExprState := default
          let some parsedBVLogicalExpr ← (parseExprs lhsExpr rhsExpr targetWidth).run' initialState
            | throwError "Unsupported expression provided"

          trace[Generalize] m! "Parsed BVLogicalExpr state: {parsedBVLogicalExpr.state}"

          let mut bvLogicalExpr := parsedBVLogicalExpr.bvLogicalExpr
          let parsedBVState := parsedBVLogicalExpr.state
          let originalWidth := parsedBVState.originalWidth

          let mut constantAssignments := []
          --- Synthesize constants in a lower width if needed
          if originalWidth > targetWidth then
            constantAssignments ← existsForAll bvLogicalExpr parsedBVState.symVarToVal.keys parsedBVState.BVExprIdToFreeVar.keys 1

          let mut processingWidth := targetWidth
          if constantAssignments.isEmpty then
            logInfo m! "Did not synthesize new constant values in width {targetWidth}"
            constantAssignments := parsedBVState.symVarToVal :: constantAssignments
            processingWidth := originalWidth

          if processingWidth != targetWidth then
              -- Revert to the original width if necessary
            bvLogicalExpr := changeBVLogicalExprWidth bvLogicalExpr processingWidth
            trace[Generalize] m! "Using values for {bvLogicalExpr} in width {processingWidth}: {constantAssignments}"

          let initialGeneralizerState : GeneralizerState :=
            { startTime := startTime
            , widthId := 9481
            , timeout := timeoutMs
            , processingWidth           := processingWidth
            , targetWidth               := targetWidth
            , parsedBVLogicalExpr       := { parsedBVLogicalExpr with bvLogicalExpr := bvLogicalExpr }
            , needsPreconditionsExprs   := []
            , visitedSubstitutions      := Std.HashSet.emptyWithCapacity
            , constantExprsEnumerationCache  := Std.HashMap.emptyWithCapacity
            }

          let generalizeRes ← (generalize constantAssignments).run' initialGeneralizerState
          let mut variableDisplayNames := Std.HashMap.union parsedBVState.BVExprIdToFreeVar parsedBVState.symVarToDisplayName
          variableDisplayNames := variableDisplayNames.insert initialGeneralizerState.widthId "w"

          trace[Generalize] m! "All vars: {variableDisplayNames}"
          match generalizeRes with
            | some res => match context with
                          | GeneralizeContext.Command => let pretty := prettify res variableDisplayNames
                                                         pure m! "Raw generalization result: {res} \n Input expression: {hExpr} has generalization: {pretty}"
                          | GeneralizeContext.Tactic name => pure m! "{printAsTheorem name res variableDisplayNames}"
            | none => throwError m! "Could not generalize {bvLogicalExpr}"

    | _ => throwError m!"The top level constructor is not an equality predicate in {hExpr}"


elab "#generalize" expr:term: command =>
  open Lean Lean.Elab Command Term in
  withoutModifyingEnv <| runTermElabM fun _ => Term.withDeclName `_reduceWidth do
      let hExpr ← Term.elabTerm expr none
      trace[Generalize] m! "hexpr: {hExpr}"
      let res ← parseAndGeneralize hExpr GeneralizeContext.Command

      logInfo m! "{res}"

variable {x y : BitVec 8}
#generalize (0#8 - x ||| y) + y = (y ||| 0#8 - x) + y

variable {x y : BitVec 32}
--#generalize 1#32 <<< x &&& 1#32 = BitVec.zeroExtend 32 (BitVec.ofBool (x == 0#32))
#generalize BitVec.zeroExtend 32 ((BitVec.truncate 16 x) <<< 8) = (x <<< 8) &&& 0xFF00#32
-- zext( (trunc(𝑎 : i32) ≪ 8) ) ⇒(𝑎 ≪ 8) & 0xFF00


syntax (name := bvGeneralize) "bv_generalize" : tactic
@[tactic bvGeneralize]
def evalBvGeneralize : Tactic := fun
| `(tactic| bv_generalize) => do
    let name ← mkAuxDeclName `generalized
    let msg ← withoutModifyingEnv <| withoutModifyingState do
      withMainContext do
        -- let g ← getMainGoal
        -- let normalized? ← Normalize.bvNormalize g {}
        -- let some normalized := normalized? | throwError "Error!"
        -- let reflected ← (reflectBV g).run
        let expr ← Lean.Elab.Tactic.getMainTarget
        let res ← parseAndGeneralize expr (GeneralizeContext.Tactic name)
        pure m! "Generalized theorem: {res}"
       --  pure m! "{reflected.bvExpr}"
    logInfo m! "{msg}"
| _ => throwUnsupportedSyntax


set_option linter.unusedTactic false



theorem zextdemo (x : BitVec 32) : 1#32 <<< x &&& 1#32 = BitVec.zeroExtend 32 (BitVec.ofBool (x == 0#32)) := by
  bv_normalize
  bv_generalize
  sorry


theorem zextdemo2 (x : BitVec 32) : BitVec.zeroExtend 32 ((BitVec.truncate 16 x) <<< 8) = (x <<< 8) &&& 0xFF00#32 := by
  bv_normalize
  bv_generalize
  sorry

/--
info: theorem Generalize.demo.generalized_1_1 {w} (x y C1 : BitVec w) : (((C1 - x) ||| y) + y) = ((y ||| (C1 - x)) + y) := by sorry
---
warning: declaration uses 'sorry'
-/
#guard_msgs in
theorem demo (x y : BitVec 8) : (0#8 - x ||| y) + y = (y ||| 0#8 - x) + y := by
  bv_generalize
  sorry


/--
info: theorem Generalize.demo2.generalized_1_1 {w} (x C1 C2 C3 C4 C5 : BitVec w) : (((x ^^^ C1) ||| C2) ^^^ C3) = ((x &&& (~ C2)) ^^^ (((0 ^^^ C2) ||| C1) ^^^ C3)) := by sorry
---
warning: declaration uses 'sorry'
-/
#guard_msgs in
theorem demo2 (x y : BitVec 8) :  (x ^^^ -1#8 ||| 7#8) ^^^ 12#8 = x &&& BitVec.ofInt 8 (-8) ^^^ BitVec.ofInt 8 (-13) := by
  bv_generalize
  sorry

/--
info: theorem Generalize.demo3.generalized_1_1 {w} (x C1 C2 C3 : BitVec w) (h: (C1 &&& C2) = 0) : ((x &&& C1) &&& C2) = 0 := by sorry
---
warning: declaration uses 'sorry'
-/
#guard_msgs in
theorem demo3 (x y : BitVec 8) : x &&& 3#8 &&& 4#8 = 0#8 := by
  bv_generalize
  sorry

end Generalize
