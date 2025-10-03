/-
Copyright (c) 2024 Lean FRO, LLC. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Henrik Böving, Timi Adeniran, Léo Stefanesco
-/
import Lean
import Lean.Elab.Term
import Medusa.Generalize
import Fp.Basic
import Fp.Addition

open Lean
open Elab
open Lean.Meta
open Std.Sat
open Std.Tactic.BVDecide

abbrev mfixed : Nat := 3 -- Mantissa bits for f32

-- TODO: put these in a namespace in Fp.lean
/-- info: PackedFloat (exWidth sigWidth : Nat) : Type -/
#guard_msgs in #check PackedFloat

namespace Generalize

namespace Fp

inductive FpBinOp
| add
deriving Hashable, DecidableEq, Repr

def FpBinOp.toString : FpBinOp → String
  | FpBinOp.add => "+"

instance : ToString FpBinOp where
  toString := FpBinOp.toString


/--
Custom floating point expression
for generalization incorporating all supported expressions.
For now, the index is the *exponent* of the FpExpr.
-/
inductive FpExpr : (e : Nat) → Type where
  /--
  A `BitVec` variable, referred to through an index.
  -/
  | var (idx : Nat) : FpExpr e
  /--
  A binary operation.
  -/
  | bin (lhs : FpExpr e) (op : FpBinOp) (rhs : FpExpr e) : FpExpr e
  | const (val : BitVec (1 + e + mfixed)) : FpExpr e
with
  @[computed_field]
  hashCode :  (e : Nat) → FpExpr e → UInt64
    | e, .var idx => mixHash 5 <| mixHash (hash e) (hash idx)
    | e, .bin lhs op rhs =>
      mixHash 13 <| mixHash (hash e) <| mixHash (hashCode e lhs) <| mixHash (hash op) (hashCode e rhs)
    | e, .const val => mixHash 7 <| mixHash (hash e) (hash val)
  deriving Repr, DecidableEq, Inhabited, Hashable

namespace FpExpr

def toString : FpExpr e → String
  | .var idx => s!"var{idx}#{mfixed}"
  | .bin lhs op rhs => s!"({lhs.toString} {op.toString} {rhs.toString})"
  | .const val => s!"{val}"

def size : FpExpr e → Nat
  | .var _ => 1
  | .const _ => 1
  | .bin lhs _ rhs => 1 + lhs.size + rhs.size

instance : ToString (FpExpr e) := ⟨toString⟩

instance : Hashable (FpExpr e) where
  hash expr := expr.hashCode

instance : BEq (FpExpr e) where
  beq := fun a b => toString a == toString b

instance : Inhabited BVExpr.PackedBitVec where
  default := { bv := BitVec.ofNat 0 0 }

def PackedFloat.ofBV (bv : BitVec (1 + e + M)) : PackedFloat e M where
  sign := bv[e + M]
  ex := bv.extractLsb' M e
  sig := bv.extractLsb' 0 M

def PackedFloat.toBV (pf : PackedFloat e M) : BitVec (1 + e + M) :=
  let bvSign := BitVec.ofBool pf.sign
  bvSign ++ pf.ex ++ pf.sig

/--
The semantics for `FpExpr`.
-/
def eval (assign : Std.HashMap Nat BVExpr.PackedBitVec) : FpExpr e → PackedFloat e mfixed
  | .var idx =>
    let packedBv := assign[idx]!
    /-
    This formulation improves performance, as in a well formed expression the condition always holds
    so there is no need for the more involved `BitVec.truncate` logic.
    -/
    if h : packedBv.w = 1 + e + mfixed then
     PackedFloat.ofBV (packedBv.bv.cast h)
    else
      -- | TODO: This is pretty scuffed, but whatever for now.
      PackedFloat.ofBV (packedBv.bv.setWidth _)
  | .const val => PackedFloat.ofBV val
  | .bin lhs op rhs =>
      match op with
        -- | we always use RNE, since that is the standard rounding mode.
      | .add => add (eval assign lhs) (eval assign rhs) .RNE
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
| bin (lhs : FpExpr e) (op : FpBinaryPredKind) (rhs : FpExpr e)
deriving Hashable, DecidableEq, Repr, BEq


namespace FpPredicate

def size : FpPredicate → Nat
| .bin lhs _ rhs => 1 + lhs.size + rhs.size

def toString : FpPredicate → String
| bin lhs op rhs => s!"({lhs.toString} {op.toString} {rhs.toString})"

instance : ToString FpPredicate := ⟨toString⟩

instance : ToMessageData FpPredicate where
  toMessageData p := toString p

/--
The semantics for `BVPred`.
-/
def eval (assign : Std.HashMap Nat BVExpr.PackedBitVec) : FpPredicate → Bool
  | bin lhs op rhs =>
    match op with
    | .eq => (lhs.eval assign) = (rhs.eval assign)

end FpPredicate

-- | TOTOD: move this to some generic util
deriving instance Hashable for Gate
deriving instance BEq for Gate
deriving instance DecidableEq for Gate

-- | TOTOD: move this to some generic util
deriving instance Hashable for BoolExpr
deriving instance BEq for BoolExpr
deriving instance DecidableEq for BoolExpr

/--
TODO: think if this should live in Medusa lib
TODO: why is this not generalized over m and e?
TODO: I made this a `def`, while in BV it's an `abbrev`, probably to get TC synthesis going.
-/
abbrev GenFpLogicalExpr := BoolExpr (FpPredicate)

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


-- TODO: move this to Hydra.
/-
The semantics of boolean problems involving BitVec predicates as atoms.
-/
def eval (assign : Std.HashMap Nat BVExpr.PackedBitVec)
  (expr : GenFpLogicalExpr) : Bool :=
  BoolExpr.eval (·.eval assign) expr

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
  beq := fun a b =>
    if h : a.width = b.width then
      a.bvExpr = h ▸ b.bvExpr
    else
      false

instance : Hashable FpExprWrapper where
  hash a := hash a.bvExpr

instance : ToString FpExprWrapper where
  toString w :=
      s!" FpExprWrapper \{width: {w.width}, bvExpr: {w.bvExpr.toString}}"

instance : Inhabited FpExprWrapper where
  default := { bvExpr := FpExpr.var 0, width := 0 }


def getWidth (expr : Expr) : MetaM (Option Nat) := do
  match_expr expr with
  | BitVec n =>
    let x ← getNatValue? n
    logInfo "na na na FP getting width: {x}"
    return x
  | _ => pure none

-- | TODO: rename to setWidth
def changeFpExprWidth (bvExpr: FpExpr w) (target: Nat) : FpExpr target :=
  if h : w = target then
    (h ▸ bvExpr)
  else
    match bvExpr with
    | .var idx => (FpExpr.var idx : FpExpr target)
    | .bin lhs op rhs =>
      FpExpr.bin
        (changeFpExprWidth lhs target)
        op
        (changeFpExprWidth rhs target)
    | .const val =>
      -- | TODO: this is kinda nonsensical since
      -- we are *literally* truncating bits, but whatever for now.
      -- We need a better implementation to perform exponent reduction
      FpExpr.const (val.setWidth _)

-- TODO: make this part of Medusa proper?
def changeFpLogicalExprWidth (bvLogicalExpr: GenFpLogicalExpr) (target: Nat) : GenFpLogicalExpr :=
  match bvLogicalExpr with
  | .literal (FpPredicate.bin lhs op rhs) => BoolExpr.literal (FpPredicate.bin (changeFpExprWidth lhs target) op (changeFpExprWidth rhs target))
  | .not boolExpr =>
      BoolExpr.not (changeFpLogicalExprWidth boolExpr target)
  | .gate op lhs rhs =>
      BoolExpr.gate op (changeFpLogicalExprWidth lhs target) (changeFpLogicalExprWidth rhs target)
  | .ite constVar auxVar op3 =>
      BoolExpr.ite (changeFpLogicalExprWidth constVar target) (changeFpLogicalExprWidth auxVar target) (changeFpLogicalExprWidth op3 target)
  | _ => bvLogicalExpr


-- | What does this do?
-- TODO: this can be done in Medusa directly?
-- IT doesn't need to live here?
def fpExprWrapperToSubstitutionValue (map: Std.HashMap Nat FpExprWrapper) :
      Std.HashMap Nat (SubstitutionValue (FpExpr)) :=
        Std.HashMap.ofList (List.map (fun item => (item.fst, SubstitutionValue.genExpr item.snd.bvExpr)) map.toList)

-- | This does not need to happen here?
-- TODO: part of this can happen in Medusa dir
-- | TODO: this can fail! We are casting with a proof given by `sorry` but this is nonsense.
def substituteBVExpr (bvExpr: FpExpr w) (assignment: Std.HashMap Nat (SubstitutionValue FpExpr)) : FpExpr w :=
    match bvExpr with
    | .var idx =>
      if assignment.contains idx then
          let value := assignment[idx]!
          match value with
          | .genExpr (w := wbv) bv =>
            if h : w = wbv then
              -- TODO: Scuffed
              h ▸ bv
            else
              default
          | .packedBV packedBitVec =>
            FpExpr.const (packedBitVec.bv.setWidth _)
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

-- TODO: what are identity and absorption constraints for Fp?
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

        getBitwiseConstraints {w}
          (_bvExpr: FpExpr w)
          (_op : FpBinOp) : List GenFpLogicalExpr :=
            []

-- | TODO: write this as a filter / map
def addConstraints (expr: GenFpLogicalExpr) (constraints: List GenFpLogicalExpr) (op: Gate) : GenFpLogicalExpr :=
  match constraints with
  | [] => expr
  | x::xs =>
      match expr with
      | BoolExpr.const _ => addConstraints x xs op
      | _ => addConstraints (BoolExpr.gate op expr x) xs op

def packedBitVecToFpSubstitutionValue (map: Std.HashMap Nat BVExpr.PackedBitVec) :
    Std.HashMap Nat (SubstitutionValue FpExpr) :=
  Std.HashMap.ofList (List.map (fun item => (item.fst, SubstitutionValue.packedBV item.snd)) map.toList)

def sameBothSides (bvLogicalExpr : GenFpLogicalExpr) : Bool :=
    match bvLogicalExpr with
  | .literal (FpPredicate.bin lhs _ rhs) => lhs == rhs
  | _ => false

-- TODO: can this be moved to generalize?
def evalBVExpr (assignments : Std.HashMap Nat BVExpr.PackedBitVec) (expr: FpExpr w) : PackedFloat w mfixed :=
  let substitutedBvExpr := substituteBVExpr expr (packedBitVecToFpSubstitutionValue assignments)
  FpExpr.eval assignments substitutedBvExpr

-- TODO: can this be moved to generalize?
def evalBVLogicalExpr (assignments : Std.HashMap Nat BVExpr.PackedBitVec) (expr: GenFpLogicalExpr) : Bool :=
  let substitutedBvExpr := substitute expr (packedBitVecToFpSubstitutionValue assignments)
  GenFpLogicalExpr.eval assignments substitutedBvExpr

def add (op1 : FpExpr w) (op2 : FpExpr w) : FpExpr w :=
  FpExpr.bin op1 FpBinOp.add op2

def zero (w: Nat) : FpExpr w :=
  FpExpr.const (PackedFloat.toBits <| PackedFloat.getZero _ _)

def eqToZero (expr: FpExpr w) : GenFpLogicalExpr :=
  BoolExpr.literal (FpPredicate.bin expr FpBinaryPredKind.eq (zero w))
