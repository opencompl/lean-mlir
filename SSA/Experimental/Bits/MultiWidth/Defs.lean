import Mathlib.Algebra.Notation.Defs
import Mathlib.Order.Notation
import SSA.Experimental.Bits.Fast.FiniteStateMachine
import SSA.Experimental.Bits.Vars
import Lean

import Std.Tactic.BVDecide

namespace MultiWidth

inductive WidthExpr (wcard : Nat) : Type
| var : (v : Fin wcard) → WidthExpr wcard

structure PackedWidthExpr where
  wcard : Nat
  e : WidthExpr wcard


def WidthExpr.castLe {wcard : Nat} (e : WidthExpr wcard) (hw : wcard ≤ wcard') : WidthExpr wcard' :=
  match e with
  | .var v => .var ⟨v, by omega⟩

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

inductive BinaryRelationKind
| eq
deriving DecidableEq, Repr, Inhabited

inductive Predicate
  (ctx : Term.Ctx wcard tcard) : Type
| binRel (k : BinaryRelationKind)
    (a : Term ctx w) (b : Term ctx w) : Predicate ctx
| and (p1 p2 : Predicate ctx) : Predicate ctx
| or (p1 p2 : Predicate ctx) : Predicate ctx
| not (p : Predicate ctx) : Predicate ctx

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
    (tenv : tctx.Env wenv) :
    BitStream :=
  BitStream.ofBitVec (t.toBV tenv)

def Predicate.toBitstream {tctx : Term.Ctx wcard tcard}
    (p : Predicate tctx)
    {wenv : WidthExpr.Env wcard}
    (tenv : tctx.Env wenv) :
    BitStream :=
  match p with
  | .binRel k a b =>
    match k with
    | .eq => fun i => a.toBitstream tenv i = b.toBitstream tenv i
  | .and p1 p2 => (p1.toBitstream tenv) &&& (p2.toBitstream tenv)
  | .or p1 p2 => (p1.toBitstream tenv) ||| (p2.toBitstream tenv)
  | .not p => ~~~ (p.toBitstream tenv)

end ToBitstream


namespace Decide
theorem Predicate.toProp_of_decide
    {wcard tcard : Nat}
    {tctx : Term.Ctx wcard tcard} (p : Predicate tctx) (hdecide : decide (1 = 1) = true) :
    (∀ {wenv : WidthExpr.Env wcard} (tenv : tctx.Env wenv), p.toProp tenv) := by sorry
end Decide

namespace Nondep

structure WidthExpr where ofNat ::
  toNat : Nat
deriving Inhabited, Repr, Hashable, DecidableEq

def WidthExpr.wcard (w : WidthExpr) : Nat :=
  w.toNat + 1

def WidthExpr.toPacked (w : WidthExpr) : PackedWidthExpr where
  wcard := w.toNat + 1
  e := .var ⟨w.toNat, by simp⟩

def WidthExpr.ofDep {wcard : Nat} (w : MultiWidth.WidthExpr wcard) : WidthExpr :=
    match w with
    | .var v => { toNat := v }

inductive Term
| var (v : Nat) (w : WidthExpr) : Term
| add (a b : Term) : Term
| zext (a : Term) (wnew : WidthExpr) : Term
| sext (a : Term) (wnew : WidthExpr) : Term
deriving DecidableEq, Inhabited, Repr

def Term.ofDep {wcard tcard : Nat}
    {tctx :Term.Ctx wcard tcard}
    {w : MultiWidth.WidthExpr wcard}
    (t : MultiWidth.Term tctx w) : Term :=
  match t with 
  | .var v => .var v (.ofDep w)
  | .add a b => .add (.ofDep a) (.ofDep b)
  | .zext a wnew => .zext (.ofDep a) (.ofDep wnew)
  | .sext a wnew => .sext (.ofDep a) (.ofDep wnew)

def Term.width (t : Term) : WidthExpr :=
  match t with
  | .var _v w => w
  | .add a _b => a.width
  | .zext _a wnew => wnew
  | .sext _a wnew => wnew

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
| not (p : Predicate) : Predicate
deriving DecidableEq, Inhabited, Repr

def Predicate.wcard (p : Predicate) : Nat :=
  match p with
  | .binRel .eq a _b => a.wcard
  | .or p1 p2 => max (Predicate.wcard p1) (Predicate.wcard p2)
  | .and p1 p2 => max (Predicate.wcard p1) (Predicate.wcard p2)
  | .not p => Predicate.wcard p

def Predicate.tcard (p : Predicate) : Nat :=
  match p with
  | .binRel .eq a b => max a.tcard b.tcard
  | .or p1 p2 => max (Predicate.tcard p1) (Predicate.tcard p2)
  | .and p1 p2 => max (Predicate.tcard p1) (Predicate.tcard p2)
  | .not p => Predicate.tcard p

def Predicate.ofDep {wcard tcard : Nat}
    {tctx : Term.Ctx wcard tcard} (p : MultiWidth.Predicate tctx) : Predicate :=
  match p with 
  | .binRel k a b =>
    match k with
    | .eq  => .binRel .eq (.ofDep a) (.ofDep b)
  | .or p1 p2 => .or (.ofDep p1) (.ofDep p2)
  | .and p1 p2 => .and (.ofDep p1) (.ofDep p2)
  | .not p => .not (.ofDep p)

end Nondep

section ToFSM

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


/--
A bitstream environment.
-/
structure Term.Ctx.GoodBitstreamEnv {wcard tcard : Nat}
  (bs : StateSpace wcard tcard → BitStream)
  {wenv : WidthExpr.Env wcard}
  {tctx : Term.Ctx wcard tcard}
  (tenv : tctx.Env wenv) where
  hw : ∀ (v : Fin wcard),
    BitStream.ofNat (wenv v)  = bs (StateSpace.widthVar v)
  ht : ∀ (v : Fin tcard),
    BitStream.ofBitVec (tenv v) = bs (StateSpace.termVar v)

/-- the FSM that corresponds to a given nat-predicate. -/
structure NatFSM (wcard tcard : Nat) (v : Nondep.WidthExpr) where
  fsm : FSM (StateSpace wcard tcard)

structure TermFSM (wcard tcard : Nat) (t : Nondep.Term) where
  fsm : FSM (StateSpace wcard tcard)

structure PredicateFSM (wcard tcard : Nat) (p : Nondep.Predicate) where
  fsm : FSM (StateSpace wcard tcard)

structure GoodNatFSM {wcard : Nat} (v : WidthExpr wcard) (tcard : Nat)
  extends NatFSM wcard tcard (.ofDep v) where
  heval_eq :
    ∀ (env : Fin wcard → Nat)
    (fsmEnv : StateSpace wcard tcard → BitStream),
      fsm.eval fsmEnv = v.toBitstream env

structure GoodTermFSM {w : WidthExpr wcard}
  {tctx : Term.Ctx wcard tcard}
  (t : Term tctx w) extends TermFSM wcard tcard (.ofDep t) where
  heval_eq :
    ∀ {wenv : WidthExpr.Env wcard} (tenv : tctx.Env wenv)
      (fsmEnv : StateSpace wcard tcard → BitStream),
      fsm.eval fsmEnv = t.toBitstream tenv

structure GoodPredicateFSM
  {tctx : Term.Ctx wcard tcard}
  (p : Predicate tctx) extends PredicateFSM wcard tcard (.ofDep p) where
  heval_eq :
    ∀ {wenv : WidthExpr.Env wcard} (tenv : tctx.Env wenv)
      (fsmEnv : StateSpace wcard tcard → BitStream),
      fsm.eval fsmEnv = p.toBitstream tenv

end ToFSM
end MultiWidth
