/-
Copyright (c) 2024 Lean FRO, LLC. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Henrik Böving, Timi Adeniran, Léo Stefanesco
-/
import Lean
import Lean.Elab.Term
import Medusa.Generalize

open Lean
open Elab
open Lean.Meta
open Std.Sat
open Std.Tactic.BVDecide


namespace Generalize

namespace FP

inductive FpBinOp
| add
deriving Hashable, DecidableEq, Repr

def FpBinOp.toString : FpBinOp → String
  | FpBinOp.add => "+"

instance : ToString FpBinOp where
  toString := FpBinOp.toString

/--
Custom floating point expression
for generalization incorporating all supported expressions
-/
inductive FpExpr : Nat → Type where
  /--
  A `BitVec` variable, referred to through an index.
  -/
  | var (idx : Nat) : FpExpr w
  /--
  A binary operation.
  -/
  | bin (lhs : FpExpr w) (op : FpBinOp) (rhs : FpExpr w) : FpExpr w
  | const (val : BitVec w) : FpExpr w
with
  @[computed_field]
  hashCode : (w : Nat) → FpExpr w → UInt64
    | w, .var idx => mixHash 5 <| mixHash (hash w) (hash idx)
    | w, .bin lhs op rhs =>
      mixHash 13 <| mixHash (hash w) <| mixHash (hashCode _ lhs) <| mixHash (hash op) (hashCode _ rhs)
    | w, .const val => mixHash 7 <| mixHash (hash w) (hash val)
  deriving Repr, DecidableEq, Inhabited, Hashable

namespace FpExpr

def toString : FpExpr w → String
  | .var idx => s!"var{idx}#{w}"
  | .bin lhs op rhs => s!"({lhs.toString} {op.toString} {rhs.toString})"
  | .const val => s!"{val}"

def size : FpExpr w → Nat
  | .var _ => 1
  | .const _ => 1
  | .bin lhs _ rhs => 1 + lhs.size + rhs.size

instance : ToString (FpExpr w) := ⟨toString⟩

instance : Hashable (FpExpr w) where
  hash expr := expr.hashCode _

instance : BEq (FpExpr w) where
  beq := fun a b => toString a == toString b

instance : Inhabited BVExpr.PackedBitVec where
  default := { bv := BitVec.ofNat 0 0 }

/-
/--
The semantics for `FpExpr`.
-/
def eval (assign : Std.HashMap Nat BVExpr.PackedBitVec) : FpExpr w → BitVec w
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
  | .bin lhs op rhs => op.eval (eval assign lhs) (eval assign rhs)
-/
end FpExpr

inductive FpBinaryPredKind
| eq
deriving Hashable, DecidableEq, Repr

def FpBinaryPredKind.toString : FpBinaryPredKind → String
  | FpBinaryPredKind.eq => "="

instance : ToString FpBinaryPredKind := ⟨FpBinaryPredKind.toString⟩

inductive FpPredicate where
/--
A binary predicate on `FpExpr`.
-/
| bin (lhs : FpExpr w) (op : FpBinaryPredKind) (rhs : FpExpr w)
deriving Hashable, DecidableEq, Repr


namespace FpPredicate

def size : FpPredicate → Nat
| .bin lhs _ rhs => 1 + lhs.size + rhs.size

def toString : FpPredicate → String
| bin lhs op rhs => s!"({lhs.toString} {op.toString} {rhs.toString})"

instance : ToString FpPredicate := ⟨toString⟩

/-
/--
The semantics for `BVPred`.
-/
def eval (assign : Std.HashMap Nat BVExpr.PackedBitVec) : FpPredicate → Bool
  | bin lhs op rhs => op.eval (lhs.eval assign) (rhs.eval assign)
  | getLsbD expr idx => (expr.eval assign).getLsbD idx
-/

end FpPredicate

deriving instance Hashable for Gate
deriving instance BEq for Gate
deriving instance DecidableEq for Gate

deriving instance Hashable for BoolExpr
deriving instance BEq for BoolExpr
deriving instance DecidableEq for BoolExpr

/-- TODO: think if this should live in Medusa lib -/
def GenFpLogicalExpr := BoolExpr FpPredicate

def GenFpLogicalExpr.toBoolExpr (expr: GenFpLogicalExpr) :
    BoolExpr FpPredicate :=
  expr

def GenFpLogicalExpr.ofBoolExpr (expr: BoolExpr FpPredicate) :
    GenFpLogicalExpr :=
  expr


def GenFpLogicalExpr.size : GenFpLogicalExpr → Nat
| .literal x => x.size
| .const _ => 1
| .not e => 1 + (GenFpLogicalExpr.ofBoolExpr e).size
| .gate _ e₁ e₂ =>
  1 + (GenFpLogicalExpr.ofBoolExpr e₁).size + (GenFpLogicalExpr.ofBoolExpr e₂).size
| .ite e₁ e₂ e₃ => 1 + (GenFpLogicalExpr.ofBoolExpr e₁).size + (GenFpLogicalExpr.ofBoolExpr e₂).size + (GenFpLogicalExpr.ofBoolExpr e₃).size

namespace GenFpLogicalExpr


/-
/--
The semantics of boolean problems involving BitVec predicates as atoms.
-/
def eval (assign : Std.HashMap Nat BVExpr.PackedBitVec)
  (expr : GenFpLogicalExpr) : Bool :=
  BoolExpr.eval (·.eval assign) expr
-/

-- TODO: this instance was defined in terms of toString,
-- to be fixed.
instance : BEq GenFpLogicalExpr where
  beq := fun a b => a.toBoolExpr == b.toBoolExpr

instance : Hashable GenFpLogicalExpr where
  hash a := hash a.toBoolExpr

end GenFpLogicalExpr

-- | What is this for?
structure FpExprWrapper where
  width : Nat
  bvExpr: FpExpr width

-- | Why BEq and not decidableEq? whatever.
instance : BEq FpExprWrapper where
  beq := fun a b => if h : a.width = b.width then
                      a.bvExpr == h ▸ b.bvExpr
                    else false

instance : Hashable FpExprWrapper where
  hash a := hash a.bvExpr

instance : ToString FpExprWrapper where
  toString w :=
      s!" FpExprWrapper \{width: {w.width}, bvExpr: {w.bvExpr}}"

instance : Inhabited FpExprWrapper where
  default := { bvExpr := FpExpr.var 0, width := 0 }


def getWidth (expr : Expr) : MetaM (Option Nat) := do
  match_expr expr with
  | BitVec n => getNatValue? n
  | _ => pure none

-- | TODO: rename to setWidth
def changeBVExprWidth (bvExpr: FpExpr w) (target: Nat) : FpExpr target := Id.run do
  if h : w = target then
    return (h ▸ bvExpr)

  match bvExpr with
  | .var idx => (FpExpr.var idx : FpExpr target)
  | .bin lhs op rhs => FpExpr.bin (changeBVExprWidth lhs target) op (changeBVExprWidth rhs target)
  | .const val => FpExpr.const (val.setWidth target)

-- TODO: make this part of Medusa proper?
def changeBVLogicalExprWidth (bvLogicalExpr: GenFpLogicalExpr) (target: Nat) : GenFpLogicalExpr :=
  match bvLogicalExpr with
  | .literal (FpPredicate.bin lhs op rhs) => BoolExpr.literal (FpPredicate.bin (changeBVExprWidth lhs target) op (changeBVExprWidth rhs target))
  | .not boolExpr =>
      BoolExpr.not (changeBVLogicalExprWidth boolExpr target)
  | .gate op lhs rhs =>
      BoolExpr.gate op (changeBVLogicalExprWidth lhs target) (changeBVLogicalExprWidth rhs target)
  | .ite constVar auxVar op3 =>
      BoolExpr.ite (changeBVLogicalExprWidth constVar target) (changeBVLogicalExprWidth auxVar target) (changeBVLogicalExprWidth op3 target)
  | _ => bvLogicalExpr

-- | What does this do?
-- TODO: this can be done in Medusa directly?
-- IT doesn't need to live here?
def bvExprToSubstitutionValue (map: Std.HashMap Nat FpExprWrapper) :
      Std.HashMap Nat (SubstitutionValue FpExpr) :=
      Std.HashMap.ofList (List.map (fun item => (item.fst, SubstitutionValue.genExpr item.snd.bvExpr)) map.toList)

-- | This does not need to happen here?
-- TODO: part of this can happen in Medusa dir
set_option warn.sorry false in
def substituteBVExpr (bvExpr: FpExpr w) (assignment: Std.HashMap Nat (SubstitutionValue FpExpr)) : FpExpr w :=
    match bvExpr with
    | .var idx =>
      if assignment.contains idx then
          let value := assignment[idx]!
          match value with
          | .genExpr (w := wbv) bv =>
            let h : w = wbv := sorry
            h ▸ bv
          | .packedBV packedBitVec =>  FpExpr.const (BitVec.ofNat w packedBitVec.bv.toNat)
      else FpExpr.var idx
    | .bin lhs op rhs =>
        FpExpr.bin (substituteBVExpr lhs assignment) op (substituteBVExpr rhs assignment)
    | .const x => .const x

-- | TODO: this can be in Medusa?
def substitute  (bvLogicalExpr: GenFpLogicalExpr) (assignment: Std.HashMap Nat (SubstitutionValue FpExpr)) :
          GenFpLogicalExpr :=
  match bvLogicalExpr with
  | .literal (FpPredicate.bin lhs op rhs) => BoolExpr.literal (FpPredicate.bin (substituteBVExpr lhs assignment) op (substituteBVExpr rhs assignment))
  | .not boolExpr =>
      BoolExpr.not (substitute boolExpr assignment)
  | .gate op lhs rhs =>
      BoolExpr.gate op (substitute lhs assignment) (substitute rhs assignment)
  | .ite conditional pos neg =>
      BoolExpr.ite (substitute conditional assignment) (substitute pos assignment) (substitute neg assignment)
  | _ => bvLogicalExpr

def getIdentityAndAbsorptionConstraints (bvLogicalExpr: GenFpLogicalExpr) (symVars : Std.HashSet Nat) : List GenFpLogicalExpr :=
      match bvLogicalExpr with
      | .literal (FpPredicate.bin lhs _ rhs) => (getFpExprConstraints lhs) ++ (getFpExprConstraints rhs)
      | .not boolExpr => getIdentityAndAbsorptionConstraints boolExpr symVars
      | .gate _ lhs rhs => (getIdentityAndAbsorptionConstraints lhs symVars) ++ (getIdentityAndAbsorptionConstraints rhs symVars)
      | .ite constVar auxVar op3 =>
          (getIdentityAndAbsorptionConstraints constVar symVars) ++ (getIdentityAndAbsorptionConstraints auxVar symVars) ++ (getIdentityAndAbsorptionConstraints op3 symVars)
      | _ => []

      where
        getFpExprConstraints {w} (bvExpr : FpExpr w) : List GenFpLogicalExpr := Id.run do
                match bvExpr with
                | .bin lhs op rhs  =>
                      match (lhs, rhs) with
                      | (FpExpr.var lhsId, FpExpr.var rhsId) =>
                          let mut constraints := []

                          if symVars.contains lhsId then
                            constraints := getBitwiseConstraints lhs op ++ constraints

                          if symVars.contains rhsId then
                            constraints := getBitwiseConstraints rhs op ++ constraints
                          pure constraints
                      | (FpExpr.var lhsId, _) =>
                          if !symVars.contains lhsId then
                            getFpExprConstraints rhs
                          else
                            (getBitwiseConstraints lhs op) ++ (getFpExprConstraints rhs)
                      | (_, FpExpr.var rhsId) =>
                          if !symVars.contains rhsId then
                            getFpExprConstraints lhs
                          else
                         (getFpExprConstraints lhs)  ++ (getBitwiseConstraints rhs op)
                      | _ => ((getFpExprConstraints lhs) ++ (getFpExprConstraints rhs))
                      -- getFpExprConstraints operand
                | _ =>  []

        getBitwiseConstraints {w} (bvExpr: FpExpr w) (_op : FpBinOp) : List GenFpLogicalExpr :=
            let _neqZero := BoolExpr.not (BoolExpr.literal (FpPredicate.bin bvExpr FpBinaryPredKind.eq (FpExpr.const (BitVec.ofNat w 0))))
            let _neqAllOnes := BoolExpr.not (BoolExpr.literal (FpPredicate.bin bvExpr FpBinaryPredKind.eq (FpExpr.const (BitVec.allOnes w))))
            []

-- | TODO: write this as a filter / map
def addConstraints (expr: GenFpLogicalExpr) (constraints: List GenFpLogicalExpr) (op: Gate) : GenFpLogicalExpr :=
  match constraints with
  | [] => expr
  | x::xs =>
      match expr with
      | BoolExpr.const _ => addConstraints x xs op
      | _ => addConstraints (BoolExpr.gate op expr x) xs op

private def packedBitVecToSubstitutionValue (map: Std.HashMap Nat BVExpr.PackedBitVec) :
    Std.HashMap Nat (SubstitutionValue FpExpr) :=
  Std.HashMap.ofList (List.map (fun item => (item.fst, SubstitutionValue.packedBV item.snd)) map.toList)

def sameBothSides (bvLogicalExpr : GenFpLogicalExpr) : Bool :=
    match bvLogicalExpr with
  | .literal (FpPredicate.bin lhs _ rhs) => lhs == rhs
  | _ => false

/-- warning: declaration uses 'sorry' -/
#guard_msgs in noncomputable def evalBVExpr (assignments : Std.HashMap Nat BVExpr.PackedBitVec) (expr: FpExpr w) : BitVec w :=
  let substitutedBvExpr := substituteBVExpr expr (packedBitVecToSubstitutionValue assignments)
  sorry
  -- FpExpr.eval assignments substitutedBvExpr

/-- warning: declaration uses 'sorry' -/
#guard_msgs in noncomputable def evalBVLogicalExpr (assignments : Std.HashMap Nat BVExpr.PackedBitVec) (expr: GenFpLogicalExpr) : Bool :=
  let substitutedBvExpr := substitute expr (packedBitVecToSubstitutionValue assignments)
  sorry
  -- GenFpLogicalExpr.eval assignments substitutedBvExpr

def add (op1 : FpExpr w) (op2 : FpExpr w) : FpExpr w :=
  FpExpr.bin op1 FpBinOp.add op2

-- | This is untrue.
def zero (w: Nat) := FpExpr.const (BitVec.ofNat w 0)

def eqToZero (expr: FpExpr w) : GenFpLogicalExpr :=
  BoolExpr.literal (FpPredicate.bin expr FpBinaryPredKind.eq (zero w))
