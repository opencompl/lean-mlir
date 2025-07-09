import Mathlib.Algebra.Notation.Defs
import Mathlib.Order.Notation
import SSA.Experimental.Bits.Fast.FiniteStateMachine
import SSA.Experimental.Bits.Vars

import Std.Tactic.BVDecide

namespace MultiWidth

inductive WidthExpr (n : Nat) : Type
| var : (v : Fin n) → WidthExpr n

def WidthExpr.Env (n : Nat) : Type :=
  Fin n → Nat

def WidthExpr.toNat (e : WidthExpr n) (env : Fin n → Nat) : Nat :=
  match e with
  | .var v => env v

inductive NatPredicate (n : Nat) : Type
| eq : WidthExpr n → WidthExpr n → NatPredicate n

def NatPredicate.toProp (env : Fin n → Nat) : NatPredicate n → Prop
  | .eq e1 e2 => WidthExpr.toNat e1 env = WidthExpr.toNat e2 env


abbrev Term.Ctx (wcard : Nat) (tcard : Nat) : Type :=
  Fin tcard → WidthExpr wcard

inductive Term {wcard tcard : Nat}
  (ctx : Term.Ctx wcard tcard) : (WidthExpr wcard) → Type
/-- a variable of a given width -/
| var (v : Fin tcard) : Term ctx (ctx v)
/-- addition of two terms of the same width -/
| add (a : Term ctx w) (b : Term ctx w) : Term ctx w
/-- zero extend a term to a given width -/
| zext (a : Term ctx w) (v : WidthExpr wcard) : Term ctx v
/-- sign extend a term to a given width -/
| sext (a : Term ctx w) (v : WidthExpr wcard) : Term ctx v

/--
Environments are for evaluation.
-/
abbrev Term.Env
  (tCtx : Term.Ctx wcard tcard)
  (wenv : Fin wcard → Nat) :=
  (v : Fin tcard) → BitVec ((tCtx v).toNat wenv)

/-- Evaluate a term to get a concrete bitvector expression. -/
def Term.toBV {wenv : WidthExpr.Env wcard}
    (tenv : Term.Env tcard wenv) :
  Term tcard w → BitVec (w.toNat wenv)
| .var v => tenv v
| .add a b => a.toBV tenv + b.toBV tenv
| .zext a v => (a.toBV tenv).zeroExtend (v.toNat wenv)
| .sext a v => (a.toBV tenv).signExtend (v.toNat wenv)

inductive BinaryRelationKind
| eq

inductive Predicate
  (ctx : Term.Ctx wcard tcard) : Type
| binRel (k : BinaryRelationKind)
    (a : Term ctx w) (b : Term ctx w) : Predicate ctx
| and (p1 p2 : Predicate ctx) : Predicate ctx
| or (p1 p2 : Predicate ctx) : Predicate ctx
| not (p : Predicate ctx) : Predicate ctx

def Predicate.toProp
    {tCtx : Term.Ctx wcard tcard}
    (tenv : Term.Env tCtx wenv)
    (p : Predicate tCtx) : Prop :=
  match p with
  | .binRel k a b =>
    match k with
    | .eq => a.toBV tenv = b.toBV tenv
  | .and p1 p2 => p1.toProp tenv ∧ p2.toProp tenv
  | .or p1 p2 => p1.toProp tenv ∨ p2.toProp tenv
  | .not p => ¬ p.toProp tenv

section ToBitstream

/--
A width expression denotes a bitstream, whose
value is true if for all indeces larger than 'env v'.
-/
def WidthExpr.toBitstream
  (e : WidthExpr n)
  (env : WidthExpr.Env n) : BitStream :=
  match e with
  | .var v => fun i => decide (env v ≤ i)


def Term.toBitstream {wcard tcard : Nat}
    {tctx :Term.Ctx wcard tcard}
    {w : WidthExpr wcard}
    (t : Term tctx w)
    {wenv : WidthExpr.Env wcard}
    (tenv : Term.Env tctx wenv) :
    BitStream :=
  BitStream.ofBitVec (t.toBV tenv)

def Predicate.toBitstream {tCtx : Term.Ctx wcard tcard}
    (p : Predicate tCtx)
    {wenv : WidthExpr.Env wcard}
    (tenv : Term.Env tCtx wenv) :
    BitStream :=
  match p with
  | .binRel k a b =>
    match k with
    | .eq => fun i => a.toBitstream tenv i = b.toBitstream tenv i
  | .and p1 p2 => (p1.toBitstream tenv) &&& (p2.toBitstream tenv)
  | .or p1 p2 => (p1.toBitstream tenv) ||| (p2.toBitstream tenv)
  | .not p => ~~~ (p.toBitstream tenv)

end ToBitstream

section ToFSM

inductive StateSpace (wcard tcard : Nat)
| widthVar (v : Fin wcard)
| termVar (v : Fin tcard)
deriving DecidableEq, Repr

/-- the FSM that corresponds to a given nat-predicate. -/
structure NatFSM (wcard : Nat) (v : WidthExpr wcard) where
  fsm : FSM (StateSpace wcard 0)

structure TermFSM {w : WidthExpr wcard}
  (ctx : Term.Ctx wcard tcard)
  (t : Term tCtx w) where
  fsm : FSM (StateSpace wcard tcard)

structure PredicateFSM
  {tCtx : Term.Ctx wcard tcard}
  (p : Predicate tCtx) where
  fsm : FSM (StateSpace wcard tcard)


end ToFSM

end MultiWidth
