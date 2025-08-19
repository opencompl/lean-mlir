import Mathlib.Algebra.Notation.Defs
import Mathlib.Order.Notation
import SSA.Experimental.Bits.Fast.FiniteStateMachine
import SSA.Experimental.Bits.Vars
import Lean

import Std.Tactic.BVDecide


namespace MultiWidth

inductive StateSpace (wcard tcard : Nat)
| widthVar (v : Fin wcard)
| termVar (v : Fin tcard)
deriving DecidableEq, Repr, Hashable

instance : Fintype (StateSpace wcard tcard) where
  elems :=
    let ws : Finset (Fin wcard) := Finset.univ
    let vs : Finset (Fin tcard) := Finset.univ
    let ws := ws.image StateSpace.widthVar
    let vs := vs.image StateSpace.termVar
    ws ∪ vs
  complete := by
    simp only [Finset.mem_union, Finset.mem_image, Finset.mem_univ, true_and]
    intros x
    rcases x with x | x  <;> simp


/-
op
op.toBV : Nat → BV
op.toBitStream : BitStream
-/

inductive WidthExpr (wcard : Nat) : Type
| var : (v : Fin wcard) → WidthExpr wcard
| min : (v w : WidthExpr wcard) → WidthExpr wcard
| max : (v w : WidthExpr wcard) → WidthExpr wcard
| addK : (v : WidthExpr wcard) → (k : Nat) → WidthExpr wcard


/-- Cast the width expression along the fact that width is ≤. -/
def WidthExpr.castLe {wcard : Nat} (e : WidthExpr wcard) (hw : wcard ≤ wcard') : WidthExpr wcard' :=
  match e with
  | .var v => .var ⟨v, by omega⟩
  | .min v w => .min (v.castLe hw) (w.castLe hw)
  | .max v w => .max (v.castLe hw) (w.castLe hw)
  | .addK v k => .addK (v.castLe hw) k

abbrev WidthExpr.Env (wcard : Nat) : Type :=
  Fin wcard → Nat

def WidthExpr.Env.empty : WidthExpr.Env 0 :=
  fun v => v.elim0

def WidthExpr.Env.cons (env : WidthExpr.Env wcard) (w : Nat) :
  WidthExpr.Env (wcard + 1) :=
  fun v => v.cases w env

def WidthExpr.toNat (e : WidthExpr wcard) (env : WidthExpr.Env wcard) : Nat :=
  match e with
  | .var v => env v
  | .min v w => Nat.min (v.toNat env) (w.toNat env)
  | .max v w => Nat.max (v.toNat env) (w.toNat env)
  | .addK v k => v.toNat env + k

def WidthExpr.toBitStream (e : WidthExpr wcard)
  (bsEnv : StateSpace wcard tcard → BitStream) : BitStream :=
  match e with
  | .var v => bsEnv (StateSpace.widthVar v)
  | .min v w => BitStream.minUnary (v.toBitStream bsEnv) (w.toBitStream bsEnv)
  | .max v w => BitStream.maxUnary (v.toBitStream bsEnv) (w.toBitStream bsEnv)
  | .addK v k => BitStream.addKUnary (v.toBitStream bsEnv) k

@[simp]
def WidthExpr.toNat_var (v : Fin wcard) (env : WidthExpr.Env wcard) :
    WidthExpr.toNat (.var v) env = env v := rfl

inductive NatPredicate (wcard : Nat) : Type
| eq : WidthExpr wcard → WidthExpr wcard → NatPredicate wcard

def NatPredicate.toProp (env : Fin wcard → Nat) : NatPredicate wcard → Prop
| .eq e1 e2 => WidthExpr.toNat e1 env = WidthExpr.toNat e2 env


abbrev Term.Ctx (wcard : Nat) (tcard : Nat) : Type :=
  Fin tcard → WidthExpr wcard

def Term.Ctx.empty (wcard : Nat) : Term.Ctx wcard 0 :=
  fun x => x.elim0

def Term.Ctx.cons {wcard : Nat} {tcard : Nat} (ctx : Term.Ctx wcard tcard)
  (w : WidthExpr wcard) : Term.Ctx wcard (tcard + 1) :=
  fun v =>
    v.cases w (fun v' => ctx v')

inductive Term {wcard tcard : Nat}
  (tctx : Term.Ctx wcard tcard) : (WidthExpr wcard) → Type
/-- a variable of a given width -/
| var (v : Fin tcard) : Term tctx (tctx v)
/-- addition of two terms of the same width -/
| add (a : Term tctx w) (b : Term tctx w) : Term tctx w
/-- zero extend a term to a given width -/
| zext (a : Term tctx w) (v : WidthExpr wcard) : Term tctx v
/-- sign extend a term to a given width -/
| sext (a : Term tctx w) (v : WidthExpr wcard) : Term tctx v

structure PackedTerm where
  wcard : Nat
  tcard : Nat
  tctx : Term.Ctx wcard tcard
  w : WidthExpr wcard
  t : Term tctx w

/--
Environments are for evaluation.
-/
abbrev Term.Ctx.Env
  (tctx : Term.Ctx wcard tcard)
  (wenv : WidthExpr.Env wcard) :=
  (v : Fin tcard) → BitVec ((tctx v).toNat wenv)

def Term.Ctx.Env.empty
  {wcard : Nat} (wenv : WidthExpr.Env wcard) (ctx : Term.Ctx wcard 0) :
  Term.Ctx.Env ctx wenv :=
  fun v => v.elim0

def Term.Ctx.Env.cons
  {wcard : Nat} {wenv : Fin wcard → Nat}
  {tctx : Term.Ctx wcard tcard}
  (tenv : tctx.Env wenv)
  (wexpr : WidthExpr wcard)
  {w : Nat} (bv : BitVec w)
  (hw : w = wexpr.toNat wenv) :
  Term.Ctx.Env (tctx.cons wexpr) wenv :=
  fun v => v.cases (bv.cast hw) (fun w => tenv w)

/-- Evaluate a term to get a concrete bitvector expression. -/
def Term.toBV {wenv : WidthExpr.Env wcard}
    {tctx : Term.Ctx wcard tcard}
    (tenv : tctx.Env wenv) :
  Term tctx w → BitVec (w.toNat wenv)
| .var v => tenv v
| .add a b => a.toBV tenv + b.toBV tenv
| .zext a v => (a.toBV tenv).zeroExtend (v.toNat wenv)
| .sext a v => (a.toBV tenv).signExtend (v.toNat wenv)

@[simp]
theorem Term.toBV_var {wenv : WidthExpr.Env wcard}
    {tctx : Term.Ctx wcard tcard}
    (tenv : tctx.Env wenv) :
  Term.toBV tenv (.var v) = tenv v := rfl

@[simp]
theorem Term.toBV_zext {wenv : WidthExpr.Env wcard}
    {tctx : Term.Ctx wcard tcard}
    (tenv : tctx.Env wenv) (a : Term tctx w) (v : WidthExpr wcard) :
  Term.toBV tenv (.zext a v) = (a.toBV tenv).zeroExtend (v.toNat wenv) := rfl

@[simp]
theorem Term.toBV_sext {wenv : WidthExpr.Env wcard}
    {tctx : Term.Ctx wcard tcard}
    (tenv : tctx.Env wenv) (a : Term tctx w) (v : WidthExpr wcard) :
  Term.toBV tenv (.sext a v) =
    (a.toBV tenv).signExtend (v.toNat wenv) := rfl

inductive BinaryRelationKind
| eq
deriving DecidableEq, Repr, Inhabited, Lean.ToExpr

inductive Predicate
  (ctx : Term.Ctx wcard tcard) : Type
| binRel (k : BinaryRelationKind)
    (a : Term ctx w) (b : Term ctx w) : Predicate ctx
| and (p1 p2 : Predicate ctx) : Predicate ctx
| or (p1 p2 : Predicate ctx) : Predicate ctx

structure PackedPredicate where
  wcard : Nat
  tcard : Nat
  tctx : Term.Ctx wcard tcard
  p : Predicate tctx

def Predicate.toProp {wcard tcard : Nat} {wenv : WidthExpr.Env wcard}
    {tctx : Term.Ctx wcard tcard}
    (tenv : tctx.Env wenv)
    (p : Predicate tctx) : Prop :=
  match p with
  | .binRel k a b =>
    match k with
    | .eq => a.toBV tenv = b.toBV tenv
  | .and p1 p2 => p1.toProp tenv ∧ p2.toProp tenv
  | .or p1 p2 => p1.toProp tenv ∨ p2.toProp tenv

-- TODO: is this even needed?
-- Can't I directly show that the FSM corresponds to the BV?
-- def Predicate.toBitstream {tctx : Term.Ctx wcard tcard}
--     (p : Predicate tctx)
--     (bsEnv : StateSpace wcard tcard → BitStream) :
--     BitStream :=
--   match p with
--   | .binRel k a b =>
--     match k with
--     | .eq =>
--       let aStream := a.toBitstream bsEnv
--       let bStream := b.toBitstream bsEnv
--       (aStream.nxor bStream).scanAnd
--   | .and p1 p2 => (p1.toBitstream bsEnv) &&& (p2.toBitstream bsEnv)
--   | .or p1 p2 => (p1.toBitstream bsEnv) ||| (p2.toBitstream bsEnv)
--   | .not p => ~~~ (p.toBitstream bsEnv)

namespace Nondep

inductive WidthExpr where
| var : Nat → WidthExpr
| max : WidthExpr → WidthExpr → WidthExpr
| min : WidthExpr → WidthExpr → WidthExpr
| addK : WidthExpr → Nat → WidthExpr
deriving Inhabited, Repr, Hashable, DecidableEq, Lean.ToExpr

def WidthExpr.wcard (w : WidthExpr) : Nat :=
  match w with
  | .var i => i + 1
  | .max v w => Nat.max (v.wcard) (w.wcard)
  | .min v w => Nat.min (v.wcard) (w.wcard)
  | .addK v k => v.wcard + k


def WidthExpr.ofDep {wcard : Nat}
    (w : MultiWidth.WidthExpr wcard) : WidthExpr :=
  match w with
  | .var v => .var v
  | .max a b => .max (.ofDep a) (.ofDep b)
  | .min a b => .min (.ofDep a) (.ofDep b)
  | .addK a k => .addK (.ofDep a) k

@[simp]
def WidthExpr.ofDep_var {wcard : Nat} {v : Fin wcard} :
    (WidthExpr.ofDep (MultiWidth.WidthExpr.var v)) = (.var v) := rfl

@[simp]
def WidthExpr.ofDep_max {wcard : Nat} {v w : MultiWidth.WidthExpr wcard} :
    (WidthExpr.ofDep (MultiWidth.WidthExpr.max v w)) =
    (.max (.ofDep v) (.ofDep w)) := rfl

@[simp]
def WidthExpr.ofDep_min {wcard : Nat} {v w : MultiWidth.WidthExpr wcard} :
    (WidthExpr.ofDep (MultiWidth.WidthExpr.min v w)) =
    (.min (.ofDep v) (.ofDep w)) := rfl

@[simp]
def WidthExpr.ofDep_addK {wcard : Nat} {v : MultiWidth.WidthExpr wcard} {k : Nat} :
    (WidthExpr.ofDep (MultiWidth.WidthExpr.addK v k)) =
    (.addK (.ofDep v) k) := rfl

inductive Term
| var (v : Nat) (w : WidthExpr) : Term
| add (a b : Term) : Term
| zext (a : Term) (wnew : WidthExpr) : Term
| sext (a : Term) (wnew : WidthExpr) : Term
deriving DecidableEq, Inhabited, Repr, Lean.ToExpr

def Term.ofDep {wcard tcard : Nat}
    {tctx :Term.Ctx wcard tcard}
    {w : MultiWidth.WidthExpr wcard}
    (t : MultiWidth.Term tctx w) : Term :=
  match t with
  | .var v => .var v (.ofDep w)
  | .add a b => .add (.ofDep a) (.ofDep b)
  | .zext a wnew => .zext (.ofDep a) (.ofDep wnew)
  | .sext a wnew => .sext (.ofDep a) (.ofDep wnew)

@[simp]
def Term.ofDep_var {wcard tcard : Nat}
    {v : Fin tcard} {tctx : Term.Ctx wcard tcard} :
    Term.ofDep (wcard := wcard) (tcard := tcard) (tctx := tctx) (w := tctx v) (MultiWidth.Term.var v) = Term.var v (.ofDep (tctx v)) := rfl

def Term.width (t : Term) : WidthExpr :=
  match t with
  | .var _v w => w
  | .add a _b => a.width
  | .zext _a wnew => wnew
  | .sext _a wnew => wnew

/-- The width of the non-dependently typed 't' equals the width 'w',
converting into the non-dependent version. -/
@[simp]
theorem Term.width_ofDep_eq_ofDep {wcard tcard : Nat}
    {w : MultiWidth.WidthExpr wcard}
    {tctx : Term.Ctx wcard tcard}
    (t : MultiWidth.Term tctx w)
    : (Term.ofDep t).width = (.ofDep w) := by
  induction t
  case var v => simp [Term.width]
  case add v a b ha hb =>
    simp [Term.ofDep, Term.width, ha]
  case zext a wnew =>
    simp [Term.ofDep, Term.width]
  case sext a wnew =>
    simp [Term.ofDep, Term.width]

def Term.wcard (t : Term) : Nat := t.width.wcard

def Term.tcard (t : Term) : Nat :=
  match t with
  | .var v _w => v + 1
  | .add a b => max (Term.tcard a) (Term.tcard b)
  | .zext a _wnew => (Term.tcard a)
  | .sext a _wnew => (Term.tcard a)

inductive Predicate
| binRel (k : BinaryRelationKind)
    (a : Term) (b : Term) : Predicate
| or (p1 p2 : Predicate) : Predicate
| and (p1 p2 : Predicate) : Predicate
deriving DecidableEq, Inhabited, Repr, Lean.ToExpr

def Predicate.wcard (p : Predicate) : Nat :=
  match p with
  | .binRel .eq a _b => a.wcard
  | .or p1 p2 => max (Predicate.wcard p1) (Predicate.wcard p2)
  | .and p1 p2 => max (Predicate.wcard p1) (Predicate.wcard p2)

def Predicate.tcard (p : Predicate) : Nat :=
  match p with
  | .binRel .eq a b => max a.tcard b.tcard
  | .or p1 p2 => max (Predicate.tcard p1) (Predicate.tcard p2)
  | .and p1 p2 => max (Predicate.tcard p1) (Predicate.tcard p2)

def Predicate.ofDep {wcard tcard : Nat}
    {tctx : Term.Ctx wcard tcard} (p : MultiWidth.Predicate tctx) : Predicate :=
  match p with
  | .binRel k a b =>
    match k with
    | .eq  => .binRel .eq (.ofDep a) (.ofDep b)
  | .or p1 p2 => .or (.ofDep p1) (.ofDep p2)
  | .and p1 p2 => .and (.ofDep p1) (.ofDep p2)

end Nondep

section ToFSM


/-- the FSM that corresponds to a given nat-predicate. -/
structure NatFSM (wcard tcard : Nat) (v : Nondep.WidthExpr) where
  toFsm : FSM (StateSpace wcard tcard)

structure TermFSM (wcard tcard : Nat) (t : Nondep.Term) where
  toFsm : FSM (StateSpace wcard tcard)

structure PredicateFSM (wcard tcard : Nat) (p : Nondep.Predicate) where
  toFsm : FSM (StateSpace wcard tcard)

/--
Preconditions on the environments: 1. The widths are encoded in unary.
-/
structure HWidthEnv {wcard tcard : Nat}
    (fsmEnv : StateSpace wcard tcard → BitStream)
    (wenv : Fin wcard → Nat) : Prop where
    heq_width : ∀ (v : Fin wcard),
      fsmEnv (StateSpace.widthVar v) = BitStream.ofNatUnary (wenv v)

/--
Preconditions on the environments: 2. The terms are encoded in binary bitstreams.
-/
structure HTermEnv {wcard tcard : Nat}
    {wenv : Fin wcard → Nat} {tctx : Term.Ctx wcard tcard}
  (fsmEnv : StateSpace wcard tcard → BitStream) (tenv : tctx.Env wenv) : Prop
  extends HWidthEnv fsmEnv wenv where
    heq_term : ∀ (v : Fin tcard),
      fsmEnv (StateSpace.termVar v) = BitStream.ofBitVecZextMsb (tenv v)

/-- make a 'HTermEnv' of 'ofTenv'. -/
def HTermEnv.mkFsmEnvOfTenv {wcard tcard : Nat}
    {wenv : Fin wcard → Nat} {tctx : Term.Ctx wcard tcard}
    (tenv : tctx.Env wenv) :
    StateSpace wcard tcard → BitStream := fun
    | .widthVar v =>
        BitStream.ofNatUnary (wenv v)
    | .termVar v =>
      BitStream.ofBitVecZextMsb (tenv v)

@[simp]
theorem HTermEnv.of_mkFsmEnvOfTenv {wcard tcard : Nat}
    {wenv : Fin wcard → Nat} {tctx : Term.Ctx wcard tcard}
    (tenv : tctx.Env wenv) :
    HTermEnv (mkFsmEnvOfTenv tenv) tenv := by
  constructor
  · constructor
    · intros v
      simp [mkFsmEnvOfTenv]
  · intros v
    simp [mkFsmEnvOfTenv]

structure HNatFSMToBitstream {wcard : Nat} {v : WidthExpr wcard} {tcard : Nat}
   (fsm : NatFSM wcard tcard (.ofDep v)) : Prop where
  heq :
    ∀ (wenv : Fin wcard → Nat) (fsmEnv : StateSpace wcard tcard → BitStream),
    (henv : HWidthEnv fsmEnv wenv) → fsm.toFsm.eval fsmEnv =
      BitStream.ofNatUnary (v.toNat wenv)

/--
Our term FSMs start unconditionally with a '0',
and then proceed to produce outputs.
This ensures that the width-0 value is assumed to be '0',
followed by the output at a width 'i'.
-/
structure HTermFSMToBitStream {w : WidthExpr wcard}
  {tctx : Term.Ctx wcard tcard}
  {t : Term tctx w} (fsm : TermFSM wcard tcard (.ofDep t)) : Prop where
  heq :
    ∀ {wenv : WidthExpr.Env wcard} (tenv : tctx.Env wenv)
      (fsmEnv : StateSpace wcard tcard → BitStream),
      (henv : HTermEnv fsmEnv tenv) →
        fsm.toFsm.eval fsmEnv =
        BitStream.ofBitVecZextMsb (t.toBV tenv)

structure HPredFSMToBitStream
  {tctx : Term.Ctx wcard tcard}
  {p : Predicate tctx} (fsm : PredicateFSM wcard tcard (.ofDep p)) : Prop where
  heq :
    ∀ {wenv : WidthExpr.Env wcard} (tenv : tctx.Env wenv)
      (fsmEnv : StateSpace wcard tcard → BitStream),
      (henv : HTermEnv fsmEnv tenv) →
        p.toProp tenv ↔ (fsm.toFsm.eval fsmEnv = .negOne)

end ToFSM
end MultiWidth
