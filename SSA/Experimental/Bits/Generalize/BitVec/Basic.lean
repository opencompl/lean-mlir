/-
Copyright (c) 2024 Lean FRO, LLC. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Henrik Böving, Timi Adeniran, Léo Stefanesco
-/
import Lean
import Lean.Elab.Term
import SSA.Experimental.Bits.Generalize.Generalize

open Lean
open Elab
open Lean.Meta
open Std.Sat
open Std.Tactic.BVDecide

namespace Generalize
/--
Custom BVExpr for generalization incorporating all supported expressions involving `BitVec` and operations on them.
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
  | signExtend (v : Nat) (expr : GenBVExpr w) : GenBVExpr v
  | zeroExtend (v : Nat) (expr : GenBVExpr w) : GenBVExpr v
  | truncate (v : Nat) (expr : GenBVExpr w) : GenBVExpr v
with
  @[computed_field]
  hashCode : (w : Nat) → GenBVExpr w → UInt64
    | w, .var idx => mixHash 5 <| mixHash (hash w) (hash idx)
    | w, .const val => mixHash 7 <| mixHash (hash w) (hash val)
    | w, .extract start _ expr =>
      mixHash 11 <| mixHash (hash start) <| mixHash (hash w) (hashCode _ expr)
    | w, .bin lhs op rhs =>
      mixHash 13 <| mixHash (hash w) <| mixHash (hashCode _ lhs) <| mixHash (hash op) (hashCode _ rhs)
    | w, .un op operand =>
      mixHash 17 <| mixHash (hash w) <| mixHash (hash op) (hashCode _ operand)
    | w, .append lhs rhs _ =>
      mixHash 19 <| mixHash (hash w) <| mixHash (hashCode _ lhs) (hashCode _ rhs)
    | w, .replicate n expr _ =>
      mixHash 23 <| mixHash (hash w) <| mixHash (hash n) (hashCode _ expr)
    | w, .shiftLeft lhs rhs =>
      mixHash 29 <| mixHash (hash w) <| mixHash (hashCode _ lhs) (hashCode _ rhs)
    | w, .shiftRight lhs rhs =>
      mixHash 31 <| mixHash (hash w) <| mixHash (hashCode _ lhs) (hashCode _ rhs)
    | w, .arithShiftRight lhs rhs =>
      mixHash 37 <| mixHash (hash w) <| mixHash (hashCode _ lhs) (hashCode _ rhs)
    | w, .signExtend _ expr =>
      mixHash 41 <| mixHash (hash w) (hashCode _ expr)
    | w, .zeroExtend _ expr =>
      mixHash 43 <| mixHash (hash w) (hashCode _ expr)
    | w, .truncate _ expr =>
      mixHash 47 <| mixHash (hash w) (hashCode _ expr)
namespace GenBVExpr

def toString : GenBVExpr w → String
  | .var idx => s!"var{idx}#{w}"
  | .const val => ToString.toString val
  | .extract start len expr => s!"{expr.toString}[{start}, {len}]"
  | .bin lhs op rhs => s!"({lhs.toString} {op.toString} {rhs.toString})"
  | .un op operand => s!"({op.toString} {toString operand})"
  | .append lhs rhs _ => s!"({toString lhs} ++ {toString rhs})"
  | .replicate n expr _ => s!"(replicate {n} {toString expr})"
  | .shiftLeft lhs rhs => s!"({lhs.toString} << {rhs.toString})"
  | .shiftRight lhs rhs => s!"({lhs.toString} >> {rhs.toString})"
  | .arithShiftRight lhs rhs => s!"({lhs.toString} >>a {rhs.toString})"
  | .signExtend v expr => s!"(signExtend {v} {toString expr}})"
  | .zeroExtend v expr => s!"(zeroExtend {v} {toString expr}})"
  | .truncate v expr => s!"(truncate {v} {toString expr}})"

def size : GenBVExpr w → Nat
  | .var idx => 1
  | .const val => 1
  | .extract _ len expr => 1 + expr.size
  | .bin lhs _ rhs => 1 + lhs.size + rhs.size
  | .un _ operand => 1 + operand.size
  | .append lhs rhs _ => 1 + lhs.size + rhs.size
  | .replicate _ expr _ => 1 + expr.size
  | .shiftLeft lhs rhs => 1 + lhs.size + rhs.size
  | .shiftRight lhs rhs => 1 + lhs.size + rhs.size
  | .arithShiftRight lhs rhs => 1 + lhs.size + rhs.size
  | .signExtend v expr => 1 + expr.size
  | .zeroExtend v expr => 1 + expr.size
  | .truncate v expr => 1 + expr.size

instance : ToString (GenBVExpr w) := ⟨toString⟩

instance : Hashable (GenBVExpr w) where
  hash expr := expr.hashCode _

instance : BEq (GenBVExpr w) where
  beq := fun a b => toString a == toString b

instance : Inhabited BVExpr.PackedBitVec where
  default := { bv := BitVec.ofNat 0 0 }

/--
The semantics for `GenBVExpr`.
-/
def eval (assign : Std.HashMap Nat BVExpr.PackedBitVec) : GenBVExpr w → BitVec w
  | .var idx =>
    let packedBv := assign[idx]!
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
  | .signExtend n expr => BitVec.signExtend n (eval assign expr)
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

def size : GenBVPred → Nat
| .bin lhs _ rhs => 1 + lhs.size + rhs.size
| .getLsbD e _ => 1 + e.size

def toString : GenBVPred → String
  | bin lhs op rhs => s!"({lhs.toString} {op.toString} {rhs.toString})"
  | getLsbD expr idx => s!"{expr.toString}[{idx}]"

instance : ToString GenBVPred := ⟨toString⟩

/--
The semantics for `BVPred`.
-/
def eval (assign : Std.HashMap Nat BVExpr.PackedBitVec) : GenBVPred → Bool
  | bin lhs op rhs => op.eval (lhs.eval assign) (rhs.eval assign)
  | getLsbD expr idx => (expr.eval assign).getLsbD idx

end GenBVPred

abbrev GenBVLogicalExpr := BoolExpr GenBVPred


def _root_.Std.Tactic.BVDecide.BoolExpr.size : GenBVLogicalExpr → Nat
| .literal x => x.size
| .const _ => 1
| .not e => 1 + e.size
| .gate _ e₁ e₂ => 1 + e₁.size + e₂.size
| .ite e₁ e₂ e₃ => 1 + e₁.size + e₂.size + e₃.size

namespace GenBVLogicalExpr

/- inductive BoolExpr (α : Type) -/
/-   | literal : α → BoolExpr α -/
/-   | const : Bool → BoolExpr α -/
/-   | not : BoolExpr α → BoolExpr α -/
/-   | gate : Gate → BoolExpr α → BoolExpr α → BoolExpr α -/
/-   | ite : BoolExpr α → BoolExpr α → BoolExpr α → BoolExpr α -/

/--
The semantics of boolean problems involving BitVec predicates as atoms.
-/
def eval (assign : Std.HashMap Nat BVExpr.PackedBitVec) (expr : GenBVLogicalExpr) : Bool :=
  BoolExpr.eval (·.eval assign) expr

instance : BEq GenBVLogicalExpr where
  beq := fun a b => toString a == toString b

instance : Hashable GenBVLogicalExpr where
  hash a := hash (toString a)

end GenBVLogicalExpr

structure BVExprWrapper where
  width : Nat
  bvExpr: GenBVExpr width

instance : ToString BVExprWrapper where
  toString w :=
      s!" BVExprWrapper \{width: {w.width}, bvExpr: {w.bvExpr}}"

instance : Inhabited BVExprWrapper where
  default := {bvExpr := GenBVExpr.const (BitVec.ofNat 0 0), width := 0}


def getWidth (expr : Expr) : MetaM (Option Nat) := do
  match_expr expr with
  | BitVec n => getNatValue? n
  | _ => pure none

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
  | .signExtend v expr => GenBVExpr.signExtend target (changeBVExprWidth expr target)
  | .zeroExtend v expr => GenBVExpr.zeroExtend target (changeBVExprWidth expr target)
  | .truncate v expr => GenBVExpr.truncate target (changeBVExprWidth expr target)
  | _ => GenBVExpr.const (BitVec.zero target)

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

def bvExprToSubstitutionValue (map: Std.HashMap Nat (GenBVExpr w)) : Std.HashMap Nat
  (SubstitutionValue GenBVExpr) :=
      Std.HashMap.ofList (List.map (fun item => (item.fst, SubstitutionValue.genExpr item.snd)) map.toList)

def packedBitVecToSubstitutionValue (map: Std.HashMap Nat BVExpr.PackedBitVec) : Std.HashMap Nat (SubstitutionValue GenBVExpr) :=
  Std.HashMap.ofList (List.map (fun item => (item.fst, SubstitutionValue.packedBV item.snd)) map.toList)

def substituteBVExpr (bvExpr: GenBVExpr w) (assignment: Std.HashMap Nat (SubstitutionValue GenBVExpr)) : GenBVExpr w :=
    match bvExpr with
    | .var idx =>
      if assignment.contains idx then
          let value := assignment[idx]!
          match value with
          | .genExpr (w := wbv) bv =>
            let h : w = wbv := sorry
            h ▸ bv
          | .packedBV packedBitVec =>  GenBVExpr.const (BitVec.ofNat w packedBitVec.bv.toNat)
      else GenBVExpr.var idx
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
    | .signExtend w expr =>
        GenBVExpr.signExtend w (substituteBVExpr expr assignment)
    | .zeroExtend w expr =>
        GenBVExpr.zeroExtend w (substituteBVExpr expr assignment)
    | .truncate w expr =>
        GenBVExpr.truncate w (substituteBVExpr expr assignment)
    | .extract start len expr =>
        GenBVExpr.extract start len (substituteBVExpr expr assignment)
    | e => e


def substitute  (bvLogicalExpr: GenBVLogicalExpr) (assignment: Std.HashMap Nat (SubstitutionValue GenBVExpr)) :
          GenBVLogicalExpr :=
  match bvLogicalExpr with
  | .literal (GenBVPred.bin lhs op rhs) => BoolExpr.literal (GenBVPred.bin (substituteBVExpr lhs assignment) op (substituteBVExpr rhs assignment))
  | .not boolExpr =>
      BoolExpr.not (substitute boolExpr assignment)
  | .gate op lhs rhs =>
      BoolExpr.gate op (substitute lhs assignment) (substitute rhs assignment)
  | .ite conditional pos neg =>
      BoolExpr.ite (substitute conditional assignment) (substitute pos assignment) (substitute neg assignment)
  | _ => bvLogicalExpr

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

def addConstraints (expr: GenBVLogicalExpr) (constraints: List GenBVLogicalExpr) (op: Gate) : GenBVLogicalExpr :=
      match constraints with
      | [] => expr
      | x::xs =>
          match expr with
          | BoolExpr.const _ => addConstraints x xs op
          | _ => addConstraints (BoolExpr.gate op expr x) xs op


def sameBothSides (bvLogicalExpr : GenBVLogicalExpr) : Bool :=
    match bvLogicalExpr with
  | .literal (GenBVPred.bin lhs _ rhs) => lhs == rhs
  | _ => false

/-
This function expects that targetWidth >= w
-/
def evalBVExpr (assignments : Std.HashMap Nat BVExpr.PackedBitVec) (expr: GenBVExpr w) : BitVec w :=
  let substitutedBvExpr := substituteBVExpr expr (packedBitVecToSubstitutionValue assignments)
  GenBVExpr.eval assignments substitutedBvExpr


def evalBVLogicalExpr (assignments : Std.HashMap Nat BVExpr.PackedBitVec) (expr: GenBVLogicalExpr) : Bool :=
  let substitutedBvExpr := substitute expr (packedBitVecToSubstitutionValue assignments)
  GenBVLogicalExpr.eval assignments substitutedBvExpr

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

def zero (w: Nat) := GenBVExpr.const (BitVec.ofNat w 0)
def one (w: Nat) := GenBVExpr.const (BitVec.ofNat w 1)
def minusOne (w: Nat) := GenBVExpr.const (BitVec.ofInt w (-1))

def eqToZero (expr: GenBVExpr w) : GenBVLogicalExpr :=
  BoolExpr.literal (GenBVPred.bin expr BVBinPred.eq (zero w))

def positive (expr: GenBVExpr w) (widthId : Nat) : GenBVLogicalExpr :=
  let shiftDistance : GenBVExpr w :=  subtract (GenBVExpr.var widthId) (one w)
  let signVal := GenBVExpr.shiftLeft (one w) shiftDistance
  BoolExpr.literal (GenBVPred.bin expr BVBinPred.ult signVal) --- It's positive if `expr <u 2 ^ (w - 1)`

def strictlyGTZero  (expr: GenBVExpr w) (widthId : Nat)  : GenBVLogicalExpr :=
  BoolExpr.gate  Gate.and (BoolExpr.literal (GenBVPred.bin (zero w) BVBinPred.ult expr)) (positive expr widthId)

def gteZero (expr: GenBVExpr w) (widthId : Nat)  : GenBVLogicalExpr :=
  positive expr widthId

def negative (expr: GenBVExpr w) (widthId : Nat) : GenBVLogicalExpr :=
  BoolExpr.not (positive expr widthId)

def strictlyLTZero (expr: GenBVExpr w) (widthId : Nat) : GenBVLogicalExpr :=
  negative expr widthId

def lteZero (expr: GenBVExpr w) (widthId : Nat) : GenBVLogicalExpr :=
  BoolExpr.gate Gate.or (eqToZero expr) (negative expr widthId)
