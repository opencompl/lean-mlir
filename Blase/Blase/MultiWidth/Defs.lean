import Mathlib.Algebra.Notation.Defs
import Mathlib.Order.Notation
import Blase.Fast.FiniteStateMachine
import Blase.Vars
import Lean

import Std.Tactic.BVDecide


namespace MultiWidth

inductive StateSpace (wcard tcard bcard  pcard : Nat)
| widthVar (v : Fin wcard)
| termVar (v : Fin tcard)
| predVar (v : Fin pcard)
| boolVar (v : Fin bcard)
deriving DecidableEq, Repr, Hashable

instance : Fintype (StateSpace wcard tcard bcard pcard) where
  elems :=
    let ws : Finset (Fin wcard) := Finset.univ
    let ts : Finset (Fin tcard) := Finset.univ
    let bs : Finset (Fin bcard) := Finset.univ
    let ps : Finset (Fin pcard) := Finset.univ
    let ws := ws.image StateSpace.widthVar
    let ts := ts.image StateSpace.termVar
    let bs := bs.image StateSpace.boolVar
    let ps := ps.image StateSpace.predVar
    ws ∪ ts ∪ bs ∪ ps
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
| const (n : Nat) :  WidthExpr wcard
| var : (v : Fin wcard) → WidthExpr wcard
| min : (v w : WidthExpr wcard) → WidthExpr wcard
| max : (v w : WidthExpr wcard) → WidthExpr wcard
| addK : (v : WidthExpr wcard) → (k : Nat) → WidthExpr wcard


/-- Cast the width expression along the fact that width is ≤. -/
def WidthExpr.castLe {wcard : Nat} (e : WidthExpr wcard) (hw : wcard ≤ wcard') : WidthExpr wcard' :=
  match e with
  | .const n => .const n
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
  | .const n => n
  | .var v => env v
  | .min v w => Nat.min (v.toNat env) (w.toNat env)
  | .max v w => Nat.max (v.toNat env) (w.toNat env)
  | .addK v k => v.toNat env + k

@[simp]
def WidthExpr.toNat_const {n : Nat} (env : WidthExpr.Env wcard) :
    WidthExpr.toNat (.const n) env = n := rfl

@[simp]
def WidthExpr.toNat_var (v : Fin wcard) (env : WidthExpr.Env wcard) :
    WidthExpr.toNat (.var v) env = env v := rfl

@[simp]
def WidthExpr.toNat_min (v w : WidthExpr wcard) (env : WidthExpr.Env wcard) :
    WidthExpr.toNat (.min v w) env = Nat.min (v.toNat env) (w.toNat env) := rfl

@[simp]
def WidthExpr.toNat_max (v w : WidthExpr wcard) (env : WidthExpr.Env wcard) :
    WidthExpr.toNat (.max v w) env = Nat.max (v.toNat env) (w.toNat env) := rfl

@[simp]
def WidthExpr.toNat_addK (v : WidthExpr wcard) (k : Nat)
    (env : WidthExpr.Env wcard) :
    WidthExpr.toNat (.addK v k) env = v.toNat env + k := rfl

def WidthExpr.toBitStream (e : WidthExpr wcard)
  (bsEnv : StateSpace wcard tcard bcard pcard → BitStream) : BitStream :=
  match e with
  | .const n => BitStream.ofNatUnary n
  | .var v => bsEnv (StateSpace.widthVar v)
  | .min v w => BitStream.minUnary (v.toBitStream bsEnv) (w.toBitStream bsEnv)
  | .max v w => BitStream.maxUnary (v.toBitStream bsEnv) (w.toBitStream bsEnv)
  | .addK v k => BitStream.addKUnary (v.toBitStream bsEnv) k

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

inductive TermKind (wcard : Nat) : Type
| bool
| bv (w : WidthExpr wcard)  : TermKind wcard


inductive Term {wcard tcard : Nat} (bcard : Nat)
  (tctx : Term.Ctx wcard tcard) : TermKind wcard → Type
/-- A bitvector built from a natural number. -/
| ofNat (w : WidthExpr wcard) (n : Nat) : Term bcard tctx (.bv w)
/-- a variable of a given width -/
| var (v : Fin tcard) : Term bcard tctx (.bv (tctx v))
/-- addition of two terms of the same width -/
| add (a : Term bcard tctx (.bv w)) (b : Term bcard tctx (.bv w)) : Term bcard tctx (.bv w)
/-- bitwise or -/
| bor (a b : Term bcard tctx (.bv w)) : Term bcard tctx (.bv w)
/-- bitwise and -/
| band (a b : Term bcard tctx (.bv w)) : Term bcard tctx (.bv w)
/-- bitwise xor -/
| bxor (a b : Term bcard tctx (.bv w)) : Term bcard tctx (.bv w)
/-- bitwise not -/
| bnot (a : Term bcard tctx (.bv w)) : Term bcard tctx (.bv w)
/-- zero extend a term to a given width -/
| zext (a : Term bcard tctx (.bv w)) (v : WidthExpr wcard) : Term bcard tctx (.bv v)
/-- sign extend a term to a given width -/
| sext (a : Term bcard tctx (.bv w)) (v : WidthExpr wcard) : Term bcard tctx (.bv v)
-- | bvOfBool (b : Term bcard tctx .bool) : Term bcard tctx (.bv (.const 1))
-- | boolMsb (w : WidthExpr wcard) (x : Term bcard tctx (.bv w)) : Term bcard tctx .bool
-- | boolOfBool (b : Bool) : Term bcard tctx .bool
| boolVar (v : Fin bcard) : Term bcard tctx .bool


def Term.BoolEnv (bcard : Nat) : Type := Fin bcard → Bool

def Term.BoolEnv.empty : Term.BoolEnv 0 :=
  fun x => x.elim0

def Term.BoolEnv.cons {bcard : Nat}
    (env : Term.BoolEnv bcard) (b : Bool) :
  Term.BoolEnv (bcard + 1) :=
    fun v => v.cases b env

-- | TODO: refactor into `Term.Env tctx` to be uniform wrt
-- other environments that are in the term, but are parametrized
-- by their context (which for everything else is just the size)
-- of the context, since they contain the same variables.
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
  fun v => v.cases (bv.cast hw) tenv

/-- get the value of a variable from the environment. -/
def Term.Ctx.Env.get {tcard : Nat}
  {wcard : Nat} {wenv : Fin wcard → Nat}
  {tctx : Term.Ctx wcard tcard}
  (tenv : tctx.Env wenv) (i : Nat) (hi : i < tcard) :
  BitVec ((tctx ⟨i, hi⟩).toNat wenv) :=
  tenv ⟨i, hi⟩

@[simp]
def Term.Ctx.Env.cons_get_zero
  {wcard : Nat} {wenv : Fin wcard → Nat}
  {tctx : Term.Ctx wcard tcard}
  (tenv : tctx.Env wenv)
  (wexpr : WidthExpr wcard)
  {w : Nat} (bv : BitVec w)
  (hw : w = wexpr.toNat wenv)
  (h0 : 0 < tcard + 1) :
  (Term.Ctx.Env.cons tenv wexpr bv hw).get 0 h0 = bv.cast hw := rfl

@[simp]
def Term.Ctx.Env.cons_get_succ
  {wcard : Nat} {wenv : Fin wcard → Nat}
  {tctx : Term.Ctx wcard tcard}
  (tenv : tctx.Env wenv)
  (wexpr : WidthExpr wcard)
  {w : Nat} (bv : BitVec w)
  (hw : w = wexpr.toNat wenv)
  (h0 : i + 1 < tcard + 1) :
  (Term.Ctx.Env.cons tenv wexpr bv hw).get (i + 1) h0 = tenv.get i (by omega) := rfl


@[reducible]
def TermKind.denote (wenv : WidthExpr.Env wcard) : TermKind wcard → Type
| .bool => Bool
| .bv w => BitVec (w.toNat wenv)

/-- Evaluate a term to get a concrete bitvector expression. -/
def Term.toBV {wenv : WidthExpr.Env wcard}
    {tctx : Term.Ctx wcard tcard}
    (benv : Term.BoolEnv bcard)
    (tenv : tctx.Env wenv) :
  Term bcard tctx k → k.denote wenv
| .ofNat w n => BitVec.ofNat (w.toNat wenv) n
| .var v => tenv.get v.1 v.2
| .add (w := w) a b =>
    let a : BitVec (w.toNat wenv) := (a.toBV benv tenv)
    let b : BitVec (w.toNat wenv) := (b.toBV benv tenv)
    a + b
| .zext a v => (a.toBV benv tenv).zeroExtend (v.toNat wenv)
| .sext a v => (a.toBV benv tenv).signExtend (v.toNat wenv)
| .bor a b (w := w) =>
    let a : BitVec (w.toNat wenv) := (a.toBV benv tenv)
    let b : BitVec (w.toNat wenv) := (b.toBV benv tenv)
    a ||| b
| .band (w := w) a b =>
    let a : BitVec (w.toNat wenv) := (a.toBV benv tenv)
    let b : BitVec (w.toNat wenv) := (b.toBV benv tenv)
    a &&& b
| .bxor (w := w) a b =>
    let a : BitVec (w.toNat wenv) := (a.toBV benv tenv)
    let b : BitVec (w.toNat wenv) := (b.toBV benv tenv)
    a ^^^ b
| .bnot (w := w) a =>
    let a : BitVec (w.toNat wenv) := (a.toBV benv tenv)
    ~~~ a
| .boolVar v => benv v

def BoolExpr.toBool
    {tctx : Term.Ctx wcard tcard}
    (benv : Term.BoolEnv bcard)  :
  Term bcard tctx .bool → Bool
| .boolVar v => benv v

@[simp]
theorem Term.toBV_ofNat
    {tctx : Term.Ctx wcard tcard}
    (tenv : tctx.Env wenv)
    (benv : Term.BoolEnv bcard)
    (w : WidthExpr wcard) (n : Nat) :
  Term.toBV benv tenv (.ofNat w n) = BitVec.ofNat (w.toNat wenv) n := rfl

@[simp]
theorem Term.toBV_var {wenv : WidthExpr.Env wcard}
    {tctx : Term.Ctx wcard tcard}
    (benv : Term.BoolEnv bcard)
    (tenv : tctx.Env wenv) :
  Term.toBV benv tenv (.var v) = tenv v := rfl

@[simp]
theorem Term.toBV_zext {wenv : WidthExpr.Env wcard}
    {tctx : Term.Ctx wcard tcard}
    (benv : Term.BoolEnv bcard)
    (tenv : tctx.Env wenv) (a : Term bcard tctx (.bv w)) (v : WidthExpr wcard) :
  Term.toBV benv tenv (.zext a v) = (a.toBV benv tenv).zeroExtend (v.toNat wenv) := rfl

@[simp]
theorem Term.toBV_sext {wenv : WidthExpr.Env wcard}
    {tctx : Term.Ctx wcard tcard}
    (benv : Term.BoolEnv bcard)
    (tenv : tctx.Env wenv) (a : Term bcard tctx (.bv w)) (v : WidthExpr wcard) :
  Term.toBV benv tenv (.sext a v) =
    (a.toBV benv tenv).signExtend (v.toNat wenv) := rfl

@[simp]
theorem Term.toBV_add {wenv : WidthExpr.Env wcard}
    {tctx : Term.Ctx wcard tcard}
    (benv : Term.BoolEnv bcard)
    (tenv : tctx.Env wenv) (a b : Term bcard tctx (.bv w)) :
  Term.toBV benv tenv (.add a b) = a.toBV benv tenv + b.toBV benv tenv := rfl

inductive BinaryRelationKind
| eq
| ne
| ule
| slt
| sle
| ult -- unsigned less than.
deriving DecidableEq, Repr, Inhabited, Lean.ToExpr

def Predicate.Env (pcard : Nat) : Type :=
  Fin pcard → Prop

def Predicate.Env.empty : Predicate.Env 0 :=
  fun v => v.elim0

def Predicate.Env.cons {pcard : Nat} (env : Predicate.Env pcard) (p : Prop) :
  Predicate.Env (pcard + 1) :=
  fun v => v.cases p env

inductive WidthBinaryRelationKind
| eq
| le
-- lt: a < b ↔ a + 1 ≤ b
-- a ≠ b: (a < b ∨ b < a)
deriving DecidableEq, Repr, Inhabited, Lean.ToExpr

inductive Predicate (bcard : Nat)
  (tctx : Term.Ctx wcard tcard)  (pcard : Nat) : Type
| binWidthRel (k : WidthBinaryRelationKind) (wa wb : WidthExpr wcard)
| binRel (k : BinaryRelationKind) (w : WidthExpr wcard)
    (a : Term bcard tctx (.bv w)) (b : Term bcard tctx (.bv w))
| and (p1 p2 : Predicate bcard tctx pcard)
| or (p1 p2 : Predicate bcard tctx pcard)
| var (v : Fin pcard)

-- add predicate NOT, <= for bitvectors, < for bitvectors, <=
-- for widths, =, not equals for widths.

def Predicate.toProp {wcard tcard bcard pcard : Nat} {wenv : WidthExpr.Env wcard}
    {tctx : Term.Ctx wcard tcard}
    (benv : Term.BoolEnv bcard)
    (tenv : tctx.Env wenv)
    (penv : Predicate.Env pcard)
    (p : Predicate bcard tctx pcard) : Prop :=
  match p with
  | .var v => penv v
  | .binWidthRel rel wa wb =>
    match rel with
    | .eq => wa.toNat wenv = wb.toNat wenv
    | .le => wa.toNat wenv ≤ wb.toNat wenv
  | .binRel rel _w a b =>
    match rel with
    | .eq => a.toBV benv tenv = b.toBV benv tenv
    | .ne => a.toBV benv tenv ≠ b.toBV benv tenv
    | .ult => (a.toBV benv tenv).ult (b.toBV benv tenv) = true
    | .ule => (a.toBV benv tenv).ule (b.toBV benv tenv) = true
    | .slt => (a.toBV benv tenv).slt (b.toBV benv tenv) = true
    | .sle => (a.toBV benv tenv).sle (b.toBV benv tenv) = true
  | .and p1 p2 => p1.toProp benv tenv penv ∧ p2.toProp benv tenv penv
  | .or p1 p2 => p1.toProp benv tenv penv ∨ p2.toProp benv tenv penv

namespace Nondep

inductive WidthExpr where
| const : Nat → WidthExpr
| var : Nat → WidthExpr
| max : WidthExpr → WidthExpr → WidthExpr
| min : WidthExpr → WidthExpr → WidthExpr
| addK : WidthExpr → Nat → WidthExpr
deriving Inhabited, Repr, Hashable, DecidableEq, Lean.ToExpr

def WidthExpr.wcard (w : WidthExpr) : Nat :=
  match w with
  | .const _ => 0
  | .var i => i + 1
  | .max v w => Nat.max (v.wcard) (w.wcard)
  | .min v w => Nat.min (v.wcard) (w.wcard)
  | .addK v k => v.wcard + k

def WidthExpr.ofDep {wcard : Nat}
    (w : MultiWidth.WidthExpr wcard) : WidthExpr :=
  match w with
  | .const n => .const n
  | .var v => .var v
  | .max a b => .max (.ofDep a) (.ofDep b)
  | .min a b => .min (.ofDep a) (.ofDep b)
  | .addK a k => .addK (.ofDep a) k

@[simp]
def WidthExpr.ofDep_const {wcard : Nat} {n : Nat} :
    (WidthExpr.ofDep (MultiWidth.WidthExpr.const n (wcard := wcard))) =
    (.const n) := rfl

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
| ofNat (w : WidthExpr) (n : Nat) : Term
| var (v : Nat) (w : WidthExpr) : Term
| add (w : WidthExpr) (a b : Term) : Term
| zext (a : Term) (wnew : WidthExpr) : Term
| sext (a : Term) (wnew : WidthExpr) : Term
| bor (w : WidthExpr) (a b : Term) : Term
| band (w : WidthExpr) (a b : Term) : Term
| bxor (w : WidthExpr) (a b : Term) : Term
| bnot (w : WidthExpr)  (a : Term) : Term
| boolVar (v : Nat) : Term
-- | ofBool (b : BoolExpr) : Term
deriving DecidableEq, Inhabited, Repr, Lean.ToExpr

def Term.ofDep {wcard tcard bcard : Nat}
    {tctx : Term.Ctx wcard tcard}
    {k : MultiWidth.TermKind wcard}
    (t : MultiWidth.Term bcard tctx k) : Term :=
  match ht : t with
  | .ofNat w n => .ofNat (.ofDep w) n
  | .var v =>
     match hk : k with
     | .bv w => .var v (.ofDep w)
     | .bool => by contradiction
  | .add (w := w) a b => .add (.ofDep w) (.ofDep a) (.ofDep b)
  | .zext a wnew => .zext (.ofDep a) (.ofDep wnew)
  | .sext a wnew => .sext (.ofDep a) (.ofDep wnew)
  | .bor (w := w) a b => .bor (.ofDep w) (.ofDep a) (.ofDep b)
  | .band (w := w) a b => .band (.ofDep w) (.ofDep a) (.ofDep b)
  | .bxor (w := w) a b => .bxor (.ofDep w) (.ofDep a) (.ofDep b)
  | .bnot (w := w) a => .bnot (.ofDep w) (.ofDep a)
  | .boolVar v => .boolVar v


/-
def BoolExpr.ofDep
    {wcard tcard bcard : Nat}
    {tctx :Term.Ctx wcard tcard}
    (b : MultiWidth.BoolExpr bcard tctx) : BoolExpr :=
  match b with
  | .var v => .var v
  | .ofBool b => .ofBool b
  | .msb w t => .msb (.ofDep w) (.ofDep t)
end
-/

@[simp]
def Term.ofDep_var {wcard tcard : Nat} (bcard : Nat)
    {v : Fin tcard} {tctx : Term.Ctx wcard tcard} :
    Term.ofDep (wcard := wcard) (tcard := tcard) (bcard := bcard) (tctx := tctx) (MultiWidth.Term.var v) = Term.var v (.ofDep (tctx v)) := rfl

def Term.width (t : Term) : WidthExpr :=
  match t with
  -- | .ofBool _b => WidthExpr.const 1
  | .ofNat w _n => w
  | .var _v w => w
  | .add w _a _b => w
  | .zext _a wnew => wnew
  | .sext _a wnew => wnew
  | .bor w _a _b => w
  | .band w _a _b => w
  | .bxor w _a _b => w
  | .bnot w _a => w
  | .boolVar _v => WidthExpr.const 1 -- dummy width.

/-- The width of the non-dependently typed 't' equals the width 'w',
converting into the non-dependent version. -/
@[simp]
theorem Term.width_ofDep_eq_ofDep {wcard tcard : Nat} (bcard : Nat)
    {w : MultiWidth.WidthExpr wcard}
    {tctx : Term.Ctx wcard tcard}
    (t : MultiWidth.Term bcard tctx (.bv w))
    : (Term.ofDep t).width = (.ofDep w) := by
  cases t
  case ofNat n =>
    simp [Term.ofDep, Term.width]
  case var v =>
    simp [Term.width]
  case add a b =>
    simp [Term.ofDep, Term.width]
  case zext a wnew =>
    simp [Term.ofDep, Term.width]
  case sext a wnew =>
    simp [Term.ofDep, Term.width]
  case bor a b =>
    simp [Term.ofDep, Term.width]
  case band a b =>
    simp [Term.ofDep, Term.width]
  case bxor a b =>
    simp [Term.ofDep, Term.width]
  case bnot a =>
    simp [Term.ofDep, Term.width]

def Term.wcard (t : Term) : Nat := t.width.wcard

def Term.tcard (t : Term) : Nat :=
  match t with
  | .ofNat _w _n => 0
  | .var v _w => v + 1
  | .add _w a b => max (Term.tcard a) (Term.tcard b)
  | .zext a _wnew => (Term.tcard a)
  | .sext a _wnew => (Term.tcard a)
  | .bor _w a b => (max (Term.tcard a) (Term.tcard b))
  | .band _w a b => (max (Term.tcard a) (Term.tcard b))
  | .bxor _w a b => (max (Term.tcard a) (Term.tcard b))
  | .bnot _w a => (Term.tcard a)
  | .boolVar _v => 0

def Term.bcard (t : Term) : Nat :=
  match t with
  | .ofNat _w _n => 0
  | .var _v _w => 0
  | .add _w a b => max (Term.bcard a) (Term.bcard b)
  | .zext a _wnew => (Term.bcard a)
  | .sext a _wnew => (Term.bcard a)
  | .bor _w a b => (max (Term.bcard a) (Term.bcard b))
  | .band _w a b => (max (Term.bcard a) (Term.bcard b))
  | .bxor _w a b => (max (Term.bcard a) (Term.bcard b))
  | .bnot _w a => (Term.bcard a)
  | .boolVar v => v + 1

inductive Predicate
| binWidthRel (k : WidthBinaryRelationKind) (wa wb : WidthExpr) : Predicate
| binRel (k : BinaryRelationKind) (w : WidthExpr)
    (a : Term) (b : Term) : Predicate
| or (p1 p2 : Predicate) : Predicate
| and (p1 p2 : Predicate) : Predicate
| var (v : Nat) : Predicate
deriving DecidableEq, Inhabited, Repr, Lean.ToExpr

def Predicate.wcard (p : Predicate) : Nat :=
  match p with
  | .var _ => 0
  | .binWidthRel _k wa wb => Nat.max wa.wcard wb.wcard
  | .binRel .eq w _a _b => w.wcard
  | .binRel .ne w _a _b => w.wcard
  | .binRel .ult _w a _b => a.wcard
  | .binRel .ule w _a _b => w.wcard
  | .binRel .sle w _a _b => w.wcard
  | .binRel .slt w _a _b => w.wcard
  | .or p1 p2 => max (Predicate.wcard p1) (Predicate.wcard p2)
  | .and p1 p2 => max (Predicate.wcard p1) (Predicate.wcard p2)

def Predicate.tcard (p : Predicate) : Nat :=
  match p with
  | .var _ => 0
  | .binWidthRel _k _wa _wb => 0
  | .binRel .eq _w a b => max a.tcard b.tcard
  | .binRel .ne _w a b => max a.tcard b.tcard
  | .binRel .ult _w a b => max a.tcard b.tcard
  | .binRel .ule w _a _b => w.wcard
  | .binRel .sle w _a _b => w.wcard
  | .binRel .slt w _a _b => w.wcard
  | .or p1 p2 => max (Predicate.tcard p1) (Predicate.tcard p2)
  | .and p1 p2 => max (Predicate.tcard p1) (Predicate.tcard p2)

def Predicate.pcard (p : Predicate) : Nat :=
  match p with
  | .var v => v + 1
  | .binWidthRel .. => 0
  | .binRel .. => 0
  | .or p1 p2 => max (Predicate.pcard p1) (Predicate.pcard p2)
  | .and p1 p2 => max (Predicate.pcard p1) (Predicate.pcard p2)

def Predicate.ofDep {wcard tcard pcard : Nat}
    {tctx : Term.Ctx wcard tcard} (p : MultiWidth.Predicate bctx tctx pcard) : Predicate :=
  match p with
  | .var v => .var v
  | .binWidthRel .eq wa wb => .binWidthRel .eq (.ofDep wa) (.ofDep wb)
  | .binWidthRel .le wa wb => .binWidthRel .le (.ofDep wa) (.ofDep wb)
  | .binRel .eq w a b => .binRel .eq (.ofDep w) (.ofDep a) (.ofDep b)
  | .binRel .ne w a b => .binRel .ne (.ofDep w) (.ofDep a) (.ofDep b)
  | .binRel .ult w a b => .binRel .ult (.ofDep w) (.ofDep a) (.ofDep b)
  | .binRel .ule w a b => .binRel .ule (.ofDep w) (.ofDep a) (.ofDep b)
  | .binRel .slt w a b => .binRel .slt (.ofDep w) (.ofDep a) (.ofDep b)
  | .binRel .sle w a b => .binRel .sle (.ofDep w) (.ofDep a) (.ofDep b)
  | .or p1 p2 => .or (.ofDep p1) (.ofDep p2)
  | .and p1 p2 => .and (.ofDep p1) (.ofDep p2)

end Nondep

section ToFSM


/-- the FSM that corresponds to a given nat-predicate. -/
structure NatFSM (wcard tcard bcard pcard : Nat) (v : Nondep.WidthExpr) where
  toFsm : FSM (StateSpace wcard tcard bcard pcard)

structure TermFSM (wcard tcard bcard pcard : Nat) (t : Nondep.Term) where
  toFsmZext : FSM (StateSpace wcard tcard bcard pcard)
  width : NatFSM wcard tcard bcard pcard t.width

structure PredicateFSM (wcard tcard bcard pcard : Nat) (p : Nondep.Predicate) where
  toFsm : FSM (StateSpace wcard tcard bcard pcard)

/--
Preconditions on the environments: 1. The widths are encoded in unary.
-/
structure HWidthEnv {wcard tcard : Nat}
    (fsmEnv : StateSpace wcard tcard bcard pcard → BitStream)
    (wenv : Fin wcard → Nat) : Prop where
    heq_width : ∀ (v : Fin wcard),
      fsmEnv (StateSpace.widthVar v) = BitStream.ofNatUnary (wenv v)

/--
Preconditions on the environments: 2. The terms are encoded in binary bitstreams.
-/
structure HTermEnv {wcard tcard : Nat}
    {wenv : Fin wcard → Nat} {tctx : Term.Ctx wcard tcard}
  (fsmEnv : StateSpace wcard tcard bcard pcard → BitStream) (tenv : tctx.Env wenv) : Prop
  extends HWidthEnv fsmEnv wenv where
    heq_term : ∀ (v : Fin tcard),
      fsmEnv (StateSpace.termVar v) = BitStream.ofBitVecZext (tenv v)


open Classical in
noncomputable def BitStream.ofProp (p : Prop) : BitStream := fun _i => decide p

@[simp]
theorem BitStream.ofProp_eq_negOne_iff (p : Prop) :
    (BitStream.ofProp p = .negOne) ↔ p := by
  constructor
  · intro h
    have := congrFun h 0
    simp [ofProp] at this
    exact this
  · intro h
    ext i
    simp [ofProp, h]

open Classical in
@[simp]
theorem BitStream.ofProp_eq (p : Prop) : (BitStream.ofProp p i) = decide p := rfl

open Classical in
noncomputable def BitStream.ofBool (b : Bool) : BitStream := fun _i => b
@[simp]
theorem BitStream.ofBool_eq (b : Bool) : (BitStream.ofBool b i) = b := rfl




open Classical in
/-- make a 'HTermEnv' of 'ofTenv'. -/
noncomputable def HTermEnv.mkFsmEnvOfTenv {wcard tcard bcard : Nat}
    {wenv : Fin wcard → Nat} {tctx : Term.Ctx wcard tcard}
    (tenv : tctx.Env wenv) (benv : Term.BoolEnv bcard) (penv : Predicate.Env pcard) :
    StateSpace wcard tcard bcard pcard → BitStream := fun
    | .widthVar v =>
        BitStream.ofNatUnary (wenv v)
    | .termVar v =>
      BitStream.ofBitVecZext (tenv v)
    | .predVar v => BitStream.ofProp (penv v)
    | .boolVar v => BitStream.ofBool (benv v) -- dummy value.

@[simp]
theorem HTermEnv.of_mkFsmEnvOfTenv {wcard tcard : Nat}
    {wenv : Fin wcard → Nat} {tctx : Term.Ctx wcard tcard}
    (tenv : tctx.Env wenv) (benv : Term.BoolEnv bcard) (penv : Predicate.Env pcard) :
    HTermEnv (mkFsmEnvOfTenv tenv benv penv) tenv := by
  constructor
  · constructor
    · intros v
      simp [mkFsmEnvOfTenv]
  · intros v
    simp [mkFsmEnvOfTenv]

structure HPredicateEnv {wcard tcard bcard pcard : Nat}
    (fsmEnv : StateSpace wcard tcard bcard pcard → BitStream)
    (penv : Fin pcard → Prop) : Prop where
    heq_width : ∀ (v : Fin pcard),
      fsmEnv (StateSpace.predVar v) = BitStream.ofProp (penv v)

@[simp]
theorem HPredicateEnv.of_mkFsmEnvOfTenv {wcard tcard bcard pcard : Nat}
    {wenv : Fin wcard → Nat} {tctx : Term.Ctx wcard tcard}
    (tenv : tctx.Env wenv) (benv : Term.BoolEnv bcard) (penv : Predicate.Env pcard) :
    HPredicateEnv (HTermEnv.mkFsmEnvOfTenv tenv benv penv) penv := by
  constructor
  intros p
  simp [HTermEnv.mkFsmEnvOfTenv]



structure HNatFSMToBitstream {wcard : Nat} {v : WidthExpr wcard} {tcard : Nat} {bcard : Nat} {pcard : Nat}
   (fsm : NatFSM wcard tcard bcard pcard (.ofDep v)) : Prop where
  heq :
    ∀ (wenv : Fin wcard → Nat)
    (fsmEnv : StateSpace wcard tcard bcard pcard → BitStream),
    (henv : HWidthEnv fsmEnv wenv) →
      fsm.toFsm.eval fsmEnv =
      BitStream.ofNatUnary (v.toNat wenv)

/--
Our term FSMs start unconditionally with a '0',
and then proceed to produce outputs.
This ensures that the width-0 value is assumed to be '0',
followed by the output at a width 'i'.
-/
structure HTermFSMToBitStream {w : WidthExpr wcard}
  {tctx : Term.Ctx wcard tcard}
  {t : Term bcard tctx (.bv w)}
  (fsm : TermFSM wcard tcard bcard pcard (.ofDep t)) : Prop where
  heq :
    ∀ {wenv : WidthExpr.Env wcard} (benv : Term.BoolEnv bcard) (tenv : tctx.Env wenv)
      (fsmEnv : StateSpace wcard tcard bcard pcard → BitStream),
      (henv : HTermEnv fsmEnv tenv) →
        fsm.toFsmZext.eval fsmEnv =
        BitStream.ofBitVecZext (t.toBV benv tenv)

structure HPredFSMToBitStream {pcard : Nat}
  {tctx : Term.Ctx wcard tcard}
  {p : Predicate bcard tctx pcard} (fsm : PredicateFSM wcard tcard bcard pcard (.ofDep p)) : Prop where
  heq :
    ∀ {wenv : WidthExpr.Env wcard} (benv : Term.BoolEnv bcard) (tenv : tctx.Env wenv)
      (penv : Predicate.Env pcard)
      (fsmEnv : StateSpace wcard tcard bcard pcard → BitStream),
      (htenv : HTermEnv fsmEnv tenv) →
      (hpenv : HPredicateEnv fsmEnv penv) →
        p.toProp benv tenv penv ↔ (fsm.toFsm.eval fsmEnv = .negOne)

end ToFSM
end MultiWidth
