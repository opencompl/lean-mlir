import Mathlib.Algebra.Notation.Defs
import Mathlib.Order.Notation
import Blase.Fast.FiniteStateMachine
import Blase.Vars
import SexprPBV
import Lean

import Std.Tactic.BVDecide


namespace MultiWidth

inductive StateSpace (wcard tcard bcard ncard icard pcard : Nat)
| widthVar (v : Fin wcard)
| termVar (v : Fin tcard)
| predVar (v : Fin pcard)
| boolVar (v : Fin bcard)
deriving DecidableEq, Repr, Hashable

instance : Fintype (StateSpace wcard tcard bcard ncard icard pcard) where
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
| kadd : (k : Nat) → (v : WidthExpr wcard) → WidthExpr wcard


/-- Cast the width expression along the fact that width is ≤. -/
def WidthExpr.castLe {wcard : Nat} (e : WidthExpr wcard) (hw : wcard ≤ wcard') : WidthExpr wcard' :=
  match e with
  | .const n => .const n
  | .var v => .var ⟨v, by omega⟩
  | .min v w => .min (v.castLe hw) (w.castLe hw)
  | .max v w => .max (v.castLe hw) (w.castLe hw)
  | .addK v k => .addK (v.castLe hw) k
  | .kadd k v => .kadd k (v.castLe hw)

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
  | .kadd k v => k + v.toNat env

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

@[simp]
def WidthExpr.toNat_kadd (v : WidthExpr wcard) (k : Nat)
    (env : WidthExpr.Env wcard) :
    WidthExpr.toNat (.kadd k v) env = k + v.toNat env := rfl

def WidthExpr.toBitStream (e : WidthExpr wcard)
  (bsEnv : StateSpace wcard tcard bcard ncard icard pcard → BitStream) : BitStream :=
  match e with
  | .const n => BitStream.ofNatUnary n
  | .var v => bsEnv (StateSpace.widthVar v)
  | .min v w => BitStream.minUnary (v.toBitStream bsEnv) (w.toBitStream bsEnv)
  | .max v w => BitStream.maxUnary (v.toBitStream bsEnv) (w.toBitStream bsEnv)
  | .addK v k => BitStream.addKUnary (v.toBitStream bsEnv) k
  | .kadd k v => BitStream.addKUnary (v.toBitStream bsEnv) k

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

inductive BinaryRelationKind
| eq
| ne
| ule
| slt
| sle
| ult -- unsigned less than.
deriving DecidableEq, Repr, Inhabited, Lean.ToExpr

def BinaryRelationKind.toSmtLib : BinaryRelationKind → SexprPBV.BinaryRelationKind
| .eq => .eq
| .ne => .ne
| .ule => .ule
| .slt => .slt
| .sle => .sle
| .ult => .ult

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

def WidthBinaryRelationKind.toSmtLib : WidthBinaryRelationKind → SexprPBV.WidthBinaryRelationKind
| .eq => .eq
| .le => .le

inductive BoolBinaryRelationKind
| eq
deriving DecidableEq, Repr, Inhabited, Lean.ToExpr

def BoolBinaryRelationKind.toSmtLib : BoolBinaryRelationKind → SexprPBV.BoolBinaryRelationKind
| .eq => .eq



inductive TermKind (wcard : Nat) : Type
| bool
| bv (w : WidthExpr wcard)  : TermKind wcard
| prop
| nat
| int

inductive Term {wcard tcard : Nat} (bcard : Nat) (ncard : Nat) (icard : Nat) (pcard : Nat)
  (tctx : Term.Ctx wcard tcard) : TermKind wcard → Type
-- | natVar (v : Fin tcard) : Term bcard ncard icard pcard tctx .nat
-- | varNat (v : Fin tcard) : Term bcard ncard icard pcard tctx .nat
-- | varInt (v : Fin tcard) : Term bcard ncard icard pcard tctx .int
-- | ofNat (n : Term bcard ncard icard pcard tctx .nat) (w : WidthExpr wcard) : Term bcard ncard icard pcard tctx (.bv w)
-- | ofInt (n : Term bcard ncard icard pcard tctx .int) (w : WidthExpr wcard) : Term bcard ncard icard pcard tctx (.bv w)
-- | toNat (w : WidthExpr wcard) (bv : Term bcard ncard icard pcard tctx (.bv w)) : Term bcard ncard icard pcard tctx .nat
-- | toInt (w : WidthExpr wcard) (bv : Term bcard ncard icard pcard tctx (.bv w)) : Term bcard ncard icard pcard tctx .int
/-- A bitvector built from a natural number. -/
| ofNat (w : WidthExpr wcard) (n : Nat) : Term bcard ncard icard pcard tctx (.bv w)
/-- a variable of a given width -/
| var (v : Fin tcard) : Term bcard ncard icard pcard tctx (.bv (tctx v))
/-- addition of two terms of the same width -/
| add (a : Term bcard ncard icard pcard tctx (.bv w))
  (b : Term bcard ncard icard pcard tctx (.bv w)) : Term bcard ncard icard pcard tctx (.bv w)
/-- shift left by a known constant --/
| shiftl (a : Term bcard ncard icard pcard tctx (.bv w)) (k : Nat) : Term bcard ncard icard pcard tctx (.bv w)
/-- bitwise or -/
| bor (a b : Term bcard ncard icard pcard tctx (.bv w)) : Term bcard ncard icard pcard tctx (.bv w)
/-- bitwise and -/
| band (a b : Term bcard ncard icard pcard tctx (.bv w)) : Term bcard ncard icard pcard tctx (.bv w)
/-- bitwise xor -/
| bxor (a b : Term bcard ncard icard pcard tctx (.bv w)) : Term bcard ncard icard pcard tctx (.bv w)
/-- bitwise not -/
| bnot (a : Term bcard ncard icard pcard tctx (.bv w)) : Term bcard ncard icard pcard tctx (.bv w)
/-- zero extend a term to a given width -/
| zext (a : Term bcard ncard icard pcard tctx (.bv w)) (v : WidthExpr wcard) : Term bcard ncard icard pcard tctx (.bv v)
/-- setWidth a term to a given width, which is literally the same as zeroExtend. -/
| setWidth (a : Term bcard ncard icard pcard tctx (.bv w)) (v : WidthExpr wcard) : Term bcard ncard icard pcard tctx (.bv v)
/-- sign extend a term to a given width -/
| sext (a : Term bcard ncard icard pcard tctx (.bv w)) (v : WidthExpr wcard) : Term bcard ncard icard pcard tctx (.bv v)
/-- convert a bool to a bitvector of width 1 -/
| bvOfBool (b : Term bcard ncard icard pcard tctx .bool) : Term bcard ncard icard pcard tctx (.bv (.const 1))
-- | boolMsb (w : WidthExpr wcard) (x : Term bcard ncard icard pcard tctx (.bv w)) : Term bcard ncard icard pcard tctx .bool
| boolConst (b : Bool) : Term bcard ncard icard pcard tctx .bool
| boolVar (v : Fin bcard) : Term bcard ncard icard pcard tctx .bool
| binWidthRel (k : WidthBinaryRelationKind) (wa wb : WidthExpr wcard) :
    Term bcard ncard icard pcard tctx .prop
| binRel
    (k : BinaryRelationKind)
    (w : WidthExpr wcard)
    (a : Term bcard ncard icard pcard tctx (.bv w))
    (b : Term bcard ncard icard pcard tctx (.bv w)) :
    Term bcard ncard icard pcard tctx .prop
| and (p1 p2 : Term bcard ncard icard pcard tctx (.prop)) : Term bcard ncard icard pcard tctx (.prop)
| or (p1 p2 : Term bcard ncard icard pcard tctx (.prop)) : Term bcard ncard icard pcard tctx (.prop)
| pvar (v : Fin pcard) : Term bcard ncard icard pcard tctx (.prop) -- TODO: we need 'pvar' too.
-- | cast (heq : Term bcard ncard icard pcard tctx (.bv w1)) -- a cast
--        (w1 w2 : WidthExpr wcard)
--        (bv : Term bcard ncard icard pcard tctx (.bv w1)) :
--        Term bcard ncard icard pcard tctx (.bv w2)
-- | propOfBool (b : Term bcard ncard icard pcard tctx .bool) : Term bcard ncard icard pcard tctx (.prop)
-- | boolOfPropDecide (p : Term bcard ncard icard pcard tctx (.prop)) : Term bcard ncard icard pcard tctx .bool
| boolBinRel
  (k : BoolBinaryRelationKind)
  (a b : Term bcard ncard icard pcard tctx .bool) :
  Term bcard ncard icard pcard tctx (.prop)


def Term.BoolEnv (bcard : Nat) : Type := Fin bcard → Bool
def Term.BoolEnv.empty : Term.BoolEnv 0 :=
  fun x => x.elim0
def Term.BoolEnv.cons {bcard : Nat}
    (env : Term.BoolEnv bcard) (b : Bool) :
  Term.BoolEnv (bcard + 1) :=
    fun v => v.cases b env

def Term.NatEnv (ncard : Nat) : Type := Fin ncard → Nat
def Term.NatEnv.empty : Term.NatEnv 0 :=
  fun x => x.elim0
def Term.NatEnv.cons {ncard : Nat}
    (env : Term.NatEnv ncard) (b : Nat) :
  Term.NatEnv (ncard + 1) :=
    fun v => v.cases b env

def Term.IntEnv (icard : Nat) : Type := Fin icard → Nat
def Term.IntEnv.empty : Term.IntEnv 0 :=
  fun x => x.elim0
def Term.IntEnv.cons {icard : Nat}
    (env : Term.IntEnv icard) (b : Nat) :
  Term.IntEnv (icard + 1) :=
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
| .prop => Prop
| .nat => Nat
| .int => Int

def BoolExpr.toBool
    {tctx : Term.Ctx wcard tcard}
    (benv : Term.BoolEnv bcard)  :
  Term bcard ncard icard pcard tctx .bool → Bool
| .boolVar v => benv v
| .boolConst b => b

/-- Evaluate a term to get a concrete bitvector expression. -/
def Term.toBV {wenv : WidthExpr.Env wcard}
    {tctx : Term.Ctx wcard tcard}
    (benv : Term.BoolEnv bcard)
    (nenv : Term.NatEnv ncard)
    (ienv : Term.IntEnv icard)
    (penv : Predicate.Env pcard)
    (tenv : tctx.Env wenv)
    (t : Term bcard ncard icard pcard tctx k) : k.denote wenv :=
match t with
| .ofNat w n => BitVec.ofNat (w.toNat wenv) n
| .boolConst b => b
| .var v => tenv.get v.1 v.2
| .add (w := w) a b =>
    let a : BitVec (w.toNat wenv) := (a.toBV benv nenv ienv penv tenv)
    let b : BitVec (w.toNat wenv) := (b.toBV benv nenv ienv penv tenv)
    a + b
| .zext a v => (a.toBV benv nenv ienv penv tenv).zeroExtend (v.toNat wenv)
| .setWidth a v => (a.toBV benv nenv ienv penv tenv).zeroExtend (v.toNat wenv)
| .sext a v => (a.toBV benv nenv ienv penv tenv).signExtend (v.toNat wenv)
| .bor a b (w := w) =>
    let a : BitVec (w.toNat wenv) := (a.toBV benv nenv ienv penv tenv)
    let b : BitVec (w.toNat wenv) := (b.toBV benv nenv ienv penv tenv)
    a ||| b
| .band (w := w) a b =>
    let a : BitVec (w.toNat wenv) := (a.toBV benv nenv ienv penv tenv)
    let b : BitVec (w.toNat wenv) := (b.toBV benv nenv ienv penv tenv)
    a &&& b
| .bxor (w := w) a b =>
    let a : BitVec (w.toNat wenv) := (a.toBV benv nenv ienv penv tenv)
    let b : BitVec (w.toNat wenv) := (b.toBV benv nenv ienv penv tenv)
    a ^^^ b
| .bnot (w := w) a =>
    let a : BitVec (w.toNat wenv) := (a.toBV benv nenv ienv penv tenv)
    ~~~ a
| .boolVar v => benv v
| .shiftl (w := w) a k =>
    let a : BitVec (w.toNat wenv) := (a.toBV benv nenv ienv penv tenv)
    a <<< k
| .bvOfBool b => BitVec.ofBool (b.toBV benv nenv ienv penv tenv)
-- | .pvar v => penv v
| .binWidthRel rel wa wb =>
  match rel with
  | .eq => wa.toNat wenv = wb.toNat wenv
  | .le => wa.toNat wenv ≤ wb.toNat wenv
| .binRel rel _w a b =>
  match rel with
  | .eq => a.toBV benv nenv ienv penv tenv = b.toBV benv nenv ienv penv tenv
  | .ne => a.toBV benv nenv ienv penv tenv ≠ b.toBV benv nenv ienv penv tenv
  | .ult => (a.toBV benv nenv ienv penv tenv).ult (b.toBV benv nenv ienv penv tenv) = true
  | .ule => (a.toBV benv nenv ienv penv tenv).ule (b.toBV benv nenv ienv penv tenv) = true
  | .slt => (a.toBV benv nenv ienv penv tenv).slt (b.toBV benv nenv ienv penv tenv) = true
  | .sle => (a.toBV benv nenv ienv penv tenv).sle (b.toBV benv nenv ienv penv tenv) = true
| .and p1 p2 => p1.toBV benv nenv ienv penv tenv  ∧ p2.toBV benv nenv ienv penv tenv
| .or p1 p2 => p1.toBV benv nenv ienv penv tenv ∨ p2.toBV benv nenv ienv penv tenv
| .boolBinRel rel a b =>
  match rel with
  -- | TODO: rename 'toBV' to 'toBool'.
  | .eq => (a.toBV benv nenv ienv penv tenv) = (b.toBV benv nenv ienv penv tenv)
| .pvar v => penv v
-- | Term.and p1 p2 => p1.toBV benv nenv ienv penv tenv ∧ p2.toBV benv nenv ienv penv tenv

#print Term.toBV

@[simp]
theorem Term.toBV_ofNat
    {tctx : Term.Ctx wcard tcard}
    (tenv : tctx.Env wenv)
    (benv : Term.BoolEnv bcard)
    (nnenv : Term.NatEnv ncard)
    (ienv : Term.IntEnv icard)
    (w : WidthExpr wcard) (n : Nat) :
  Term.toBV benv nenv ienv penv tenv (.ofNat w n) = BitVec.ofNat (w.toNat wenv) n := rfl

@[simp]
theorem Term.toBV_var {wenv : WidthExpr.Env wcard}
    {tctx : Term.Ctx wcard tcard}
    (benv : Term.BoolEnv bcard)
    (tenv : tctx.Env wenv) :
  Term.toBV benv nenv ienv penv tenv (.var v) = tenv v := rfl

@[simp]
theorem Term.toBV_zext {wenv : WidthExpr.Env wcard}
    {tctx : Term.Ctx wcard tcard}
    (benv : Term.BoolEnv bcard)
    (tenv : tctx.Env wenv) (a : Term bcard ncard icard pcard tctx (.bv w)) (v : WidthExpr wcard) :
  Term.toBV benv nenv ienv penv tenv (.zext a v) = (a.toBV benv nenv ienv penv tenv).zeroExtend (v.toNat wenv) := rfl

@[simp]
theorem Term.toBV_setWidth {wenv : WidthExpr.Env wcard}
    {tctx : Term.Ctx wcard tcard}
    (benv : Term.BoolEnv bcard)
    (tenv : tctx.Env wenv) (a : Term bcard ncard icard pcard tctx (.bv w)) (v : WidthExpr wcard) :
  Term.toBV benv nenv ienv penv tenv (.setWidth a v) = (a.toBV benv nenv ienv penv tenv).zeroExtend (v.toNat wenv) := rfl

@[simp]
theorem Term.toBV_sext {wenv : WidthExpr.Env wcard}
    {tctx : Term.Ctx wcard tcard}
    (benv : Term.BoolEnv bcard)
    (tenv : tctx.Env wenv) (a : Term bcard ncard icard pcard tctx (.bv w)) (v : WidthExpr wcard) :
  Term.toBV benv nenv ienv penv tenv (.sext a v) =
    (a.toBV benv nenv ienv penv tenv).signExtend (v.toNat wenv) := rfl

@[simp]
theorem Term.toBV_shiftl {wenv : WidthExpr.Env wcard}
    {tctx : Term.Ctx wcard tcard}
    (benv : Term.BoolEnv bcard)
    (tenv : tctx.Env wenv) (a : Term bcard ncard icard pcard tctx (.bv w)) (k : Nat):
  Term.toBV benv nenv ienv penv tenv (.shiftl a k) = (a.toBV benv nenv ienv penv tenv) <<< k := rfl

@[simp]
theorem Term.toBV_add {wenv : WidthExpr.Env wcard}
    {tctx : Term.Ctx wcard tcard}
    (benv : Term.BoolEnv bcard)
    (tenv : tctx.Env wenv) (a b : Term bcard ncard icard pcard tctx (.bv w)) :
  Term.toBV benv nenv ienv penv tenv (.add a b) = a.toBV benv nenv ienv penv tenv + b.toBV benv nenv ienv penv tenv := rfl

@[simp]
theorem Term.toBV_ofBool {wenv : WidthExpr.Env wcard}
    {tctx : Term.Ctx wcard tcard}
    (benv : Term.BoolEnv bcard)
    (tenv : tctx.Env wenv) (b : Term bcard ncard icard pcard tctx .bool) :
  Term.toBV benv nenv ienv penv tenv (.bvOfBool b) = BitVec.ofBool (b.toBV benv nenv ienv penv tenv) := rfl

@[simp]
theorem Term.toBV_pvar {wenv : WidthExpr.Env wcard}
    {tctx : Term.Ctx wcard tcard}
    (benv : Term.BoolEnv bcard)
    (tenv : tctx.Env wenv) (v : Fin pcard) :
  Term.toBV benv nenv ienv penv tenv (.pvar v) = penv v := rfl


@[simp]
theorem Term.toBV_boolVar {wenv : WidthExpr.Env wcard}
    {tctx : Term.Ctx wcard tcard}
    (benv : Term.BoolEnv bcard)
    (tenv : tctx.Env wenv) (v : Fin bcard) :
  Term.toBV benv nenv ienv penv tenv (.boolVar v) = benv v := rfl

@[simp]
theorem Term.toBV_boolConst {wenv : WidthExpr.Env wcard}
    {tctx : Term.Ctx wcard tcard}
    (benv : Term.BoolEnv bcard)
    (tenv : tctx.Env wenv) (b : Bool) :
  Term.toBV benv nenv ienv penv tenv (.boolConst b) = b := rfl

@[simp]
theorem Term.toBV_bor {wenv : WidthExpr.Env wcard}
    {tctx : Term.Ctx wcard tcard}
    (benv : Term.BoolEnv bcard)
    (tenv : tctx.Env wenv) (a b : Term bcard ncard icard pcard tctx (.bv w)) :
  Term.toBV benv nenv ienv penv tenv (.bor a b) = a.toBV benv nenv ienv penv tenv ||| b.toBV benv nenv ienv penv tenv := rfl

@[simp]
theorem Term.toBV_band {wenv : WidthExpr.Env wcard}
    {tctx : Term.Ctx wcard tcard}
    (benv : Term.BoolEnv bcard)
    (tenv : tctx.Env wenv) (a b : Term bcard ncard icard pcard tctx (.bv w)) :
  Term.toBV benv nenv ienv penv tenv (.band a b) = a.toBV benv nenv ienv penv tenv &&& b.toBV benv nenv ienv penv tenv := rfl

@[simp]
theorem Term.toBV_bxor {wenv : WidthExpr.Env wcard}
    {tctx : Term.Ctx wcard tcard}
    (benv : Term.BoolEnv bcard)
    (tenv : tctx.Env wenv) (a b : Term bcard ncard icard pcard tctx (.bv w)) :
  Term.toBV benv nenv ienv penv tenv (.bxor a b) = a.toBV benv nenv ienv penv tenv ^^^ b.toBV benv nenv ienv penv tenv := rfl

@[simp]
theorem Term.toBV_bnot {wenv : WidthExpr.Env wcard}
    {tctx : Term.Ctx wcard tcard}
    (benv : Term.BoolEnv bcard)
    (tenv : tctx.Env wenv) (a : Term bcard ncard icard pcard tctx (.bv w)) :
  Term.toBV benv nenv ienv penv tenv (.bnot a) = ~~~ (a.toBV benv nenv ienv penv tenv) := rfl


@[simp]
theorem Term.toBV_boolBinRel {wenv : WidthExpr.Env wcard}
    {tctx : Term.Ctx wcard tcard}
    (benv : Term.BoolEnv bcard)
    (tenv : tctx.Env wenv)
    (k : BoolBinaryRelationKind)
    (a b : Term bcard ncard icard pcard tctx .bool) :
  Term.toBV benv nenv ienv penv tenv (.boolBinRel k a b) =
    match k with
    | .eq => (a.toBV benv nenv ienv penv tenv) = (b.toBV benv nenv ienv penv tenv) := rfl

@[simp]
theorem Term.toBV_binWidthRel {wenv : WidthExpr.Env wcard}
    {tctx : Term.Ctx wcard tcard}
    (benv : Term.BoolEnv bcard)
    (tenv : tctx.Env wenv)
    (k : WidthBinaryRelationKind)
    (wa wb : WidthExpr wcard) :
  Term.toBV benv nenv ienv penv tenv (.binWidthRel k wa wb) =
    match k with
    | .eq => wa.toNat wenv = wb.toNat wenv
    | .le => wa.toNat wenv ≤ wb.toNat wenv := rfl

@[simp]
theorem Term.toBV_binRel {wenv : WidthExpr.Env wcard}
    {tctx : Term.Ctx wcard tcard}
    (benv : Term.BoolEnv bcard)
    (tenv : tctx.Env wenv)
    (k : BinaryRelationKind)
    (w : WidthExpr wcard)
    (a b : Term bcard ncard icard pcard tctx (.bv w)) :
  Term.toBV benv nenv ienv penv tenv (.binRel k w a b) =
    match k with
    | .eq => a.toBV benv nenv ienv penv tenv = b.toBV benv nenv ienv penv tenv
    | .ne => a.toBV benv nenv ienv penv tenv ≠ b.toBV benv nenv ienv penv tenv
    | .ult => (a.toBV benv nenv ienv penv tenv).ult (b.toBV benv nenv ienv penv tenv) = true
    | .ule => (a.toBV benv nenv ienv penv tenv).ule (b.toBV benv nenv ienv penv tenv) = true
    | .slt => (a.toBV benv nenv ienv penv tenv).slt (b.toBV benv nenv ienv penv tenv) = true
    | .sle => (a.toBV benv nenv ienv penv tenv).sle (b.toBV benv nenv ienv penv tenv) = true := rfl

@[simp]
theorem Term.toBV_and {wenv : WidthExpr.Env wcard}
    {tctx : Term.Ctx wcard tcard}
    (benv : Term.BoolEnv bcard)
    (tenv : tctx.Env wenv)
    (p1 p2 : Term bcard ncard icard pcard tctx (.prop)) :
  Term.toBV benv nenv ienv penv tenv (.and p1 p2) = (p1.toBV benv nenv ienv penv tenv ∧ p2.toBV benv nenv ienv penv tenv) := rfl

@[simp]
theorem Term.toBV_or {wenv : WidthExpr.Env wcard}
    {tctx : Term.Ctx wcard tcard}
    (benv : Term.BoolEnv bcard)
    (tenv : tctx.Env wenv)
    (p1 p2 : Term bcard ncard icard pcard tctx (.prop)) :
  Term.toBV benv nenv ienv penv tenv (.or p1 p2) = (p1.toBV benv nenv ienv penv tenv ∨ p2.toBV benv nenv ienv penv tenv) := rfl


-- inductive Predicate :
--   (wcard : Nat) →
--   (tcard : Nat) →
--   (bcard : Nat) →
--   (tctx : Term.Ctx wcard tcard) →
--   (pcard : Nat) → Type
-- | binWidthRel (k : WidthBinaryRelationKind) (wa wb : WidthExpr wcard) :
--     Predicate wcard tcard bcard ncard icard pcard tctx pcard
-- | binRel {wcard tcard bcard : Nat} {tctx : Term.Ctx wcard tcard} {pcard : Nat}
--     (k : BinaryRelationKind)
--     (w : WidthExpr wcard)
--     (a : Term bcard ncard icard pcard tctx (.bv w))
--     (b : Term bcard ncard icard pcard tctx (.bv w)) :
--     Predicate wcard tcard bcard ncard icard pcard tctx pcard
-- | and (p1 p2 : Predicate wcard tcard bcard ncard icard pcard tctx pcard) : Predicate wcard tcard bcard ncard icard pcard tctx pcard
-- | or (p1 p2 : Predicate wcard tcard bcard ncard icard pcard tctx pcard) : Predicate wcard tcard bcard ncard icard pcard tctx pcard
-- | var (v : Fin pcard) : Predicate wcard tcard bcard ncard icard pcard tctx pcard
-- | boolBinRel  {wcard tcard bcard : Nat} {tctx : Term.Ctx wcard tcard} {pcard : Nat}
--   (k : BoolBinaryRelationKind)
--   (a b : Term bcard ncard icard pcard tctx .bool) :
--   Predicate wcard tcard bcard ncard icard pcard tctx pcard

-- add predicate NOT, <= for bitvectors, < for bitvectors, <=
-- for widths, =, not equals for widths.

-- def Predicate.toProp {wcard tcard bcard ncard icard pcard : Nat} {wenv : WidthExpr.Env wcard}
--     {tctx : Term.Ctx wcard tcard}
--     (benv : Term.BoolEnv bcard)
--     (tenv : tctx.Env wenv)
--     (penv : Predicate.Env pcard)
--     (p : Predicate wcard tcard bcard ncard icard pcard tctx pcard) : Prop :=
--   match p with
--   | .var v => penv v
--   | .binWidthRel rel wa wb =>
--     match rel with
--     | .eq => wa.toNat wenv = wb.toNat wenv
--     | .le => wa.toNat wenv ≤ wb.toNat wenv
--   | .binRel rel _w a b =>
--     match rel with
--     | .eq => a.toBV benv nenv ienv penv tenv = b.toBV benv nenv ienv penv tenv
--     | .ne => a.toBV benv nenv ienv penv tenv ≠ b.toBV benv nenv ienv penv tenv
--     | .ult => (a.toBV benv nenv ienv penv tenv).ult (b.toBV benv nenv ienv penv tenv) = true
--     | .ule => (a.toBV benv nenv ienv penv tenv).ule (b.toBV benv nenv ienv penv tenv) = true
--     | .slt => (a.toBV benv nenv ienv penv tenv).slt (b.toBV benv nenv ienv penv tenv) = true
--     | .sle => (a.toBV benv nenv ienv penv tenv).sle (b.toBV benv nenv ienv penv tenv) = true
--   | .and p1 p2 => p1.toProp benv nenv ienv penv tenv penv ∧ p2.toProp benv nenv ienv penv tenv penv
--   | .or p1 p2 => p1.toProp benv nenv ienv penv tenv penv ∨ p2.toProp benv nenv ienv penv tenv penv
--   | .boolBinRel rel a b =>
--     match rel with
--     -- | TODO: rename 'toBV' to 'toBool'.
--     | .eq => (a.toBV benv nenv ienv penv tenv) = (b.toBV benv nenv ienv penv tenv)

namespace Nondep

inductive WidthExpr where
| const : Nat → WidthExpr
| var : Nat → WidthExpr
| max : WidthExpr → WidthExpr → WidthExpr
| min : WidthExpr → WidthExpr → WidthExpr
| addK : WidthExpr → Nat → WidthExpr
| kadd : Nat → WidthExpr → WidthExpr
deriving Inhabited, Repr, Hashable, DecidableEq, Lean.ToExpr

open Std Lean in

def WidthExpr.toSmtLib : WidthExpr → SexprPBV.WidthExpr
| .const n => .const n
| .var v => .var v
| .max v w => .max v.toSmtLib w.toSmtLib
| .min v w => .min v.toSmtLib w.toSmtLib
| .addK v k => .addK v.toSmtLib k
| .kadd k v => .kadd k v.toSmtLib


def WidthExpr.wcard (w : WidthExpr) : Nat :=
  match w with
  | .const _ => 0
  | .var i => i + 1
  | .max v w => Nat.max (v.wcard) (w.wcard)
  | .min v w => Nat.min (v.wcard) (w.wcard)
  | .addK v k => v.wcard + k
  | .kadd k v => k + v.wcard

def WidthExpr.ofDep {wcard : Nat}
    (w : MultiWidth.WidthExpr wcard) : WidthExpr :=
  match w with
  | .const n => .const n
  | .var v => .var v
  | .max a b => .max (.ofDep a) (.ofDep b)
  | .min a b => .min (.ofDep a) (.ofDep b)
  | .addK a k => .addK (.ofDep a) k
  | .kadd k a => .kadd k (.ofDep a)

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

@[simp]
def WidthExpr.ofDep_kadd {wcard : Nat} {v : MultiWidth.WidthExpr wcard} {k : Nat} :
    (WidthExpr.ofDep (MultiWidth.WidthExpr.kadd k v)) =
    (.kadd k (.ofDep v)) := rfl

inductive Term
| ofNat (w : WidthExpr) (n : Nat) : Term
| var (v : Nat) (w : WidthExpr) : Term
| add (w : WidthExpr) (a b : Term) : Term
| zext (a : Term) (wnew : WidthExpr) : Term
| setWidth (a : Term) (wnew : WidthExpr) : Term
| sext (a : Term) (wnew : WidthExpr) : Term
| bor (w : WidthExpr) (a b : Term) : Term
| band (w : WidthExpr) (a b : Term) : Term
| bxor (w : WidthExpr) (a b : Term) : Term
| bnot (w : WidthExpr)  (a : Term) : Term
| boolVar (v : Nat) : Term
| boolConst (b : Bool) : Term
| shiftl (w : WidthExpr) (a : Term) (k : Nat) : Term
| bvOfBool (b : Term) : Term
| binWidthRel (k : WidthBinaryRelationKind) (wa wb : WidthExpr) : Term
| binRel (k : BinaryRelationKind) (w : WidthExpr)
    (a : Term) (b : Term) : Term
| or (p1 p2 : Term) : Term
| and (p1 p2 : Term) : Term
| pvar (v : Nat) : Term
| boolBinRel (k : BoolBinaryRelationKind)
    (a b : Term) : Term
deriving DecidableEq, Inhabited, Repr, Lean.ToExpr

def Term.toSmtLib : Term → SexprPBV.Term
| .ofNat w n => .ofNat w.toSmtLib n
| .var v w => .var v w.toSmtLib
| .add w a b => .add w.toSmtLib a.toSmtLib b.toSmtLib
| .zext a wnew => .zext a.toSmtLib wnew.toSmtLib
| .sext a wnew => .sext a.toSmtLib wnew.toSmtLib
| .setWidth a wnew => .setWidth a.toSmtLib wnew.toSmtLib
| .bor w a b => .bor w.toSmtLib a.toSmtLib b.toSmtLib
| .band w a b => .band w.toSmtLib a.toSmtLib b.toSmtLib
| .bxor w a b => .bxor w.toSmtLib a.toSmtLib b.toSmtLib
| .bnot w a => .bnot w.toSmtLib a.toSmtLib
| .boolVar v => .boolVar v
| .boolConst b => .boolConst b
| .shiftl w a k => .shiftl w.toSmtLib a.toSmtLib k
| .bvOfBool _b => .junk ("bvOfBool")
| _ => .junk "predicate"

def Term.ofDepTerm {wcard tcard bcard : Nat}
    {tctx : Term.Ctx wcard tcard}
    {k : MultiWidth.TermKind wcard}
    (t : MultiWidth.Term bcard ncard icard pcard tctx k) : Term :=
  match ht : t with
  | .ofNat w n => .ofNat (.ofDep w) n
  | .var v =>
     match hk : k with
     | .bv w => .var v (.ofDep w)
     | .bool => by contradiction
  | .add (w := w) a b => .add (.ofDep w) (Term.ofDepTerm a) (Term.ofDepTerm b)
  | .zext a wnew => .zext (Term.ofDepTerm a) (.ofDep wnew)
  | .sext a wnew => .sext (Term.ofDepTerm a) (.ofDep wnew)
  | .bor (w := w) a b => .bor (.ofDep w) (Term.ofDepTerm a) (Term.ofDepTerm b)
  | .band (w := w) a b => .band (.ofDep w) (Term.ofDepTerm a) (Term.ofDepTerm b)
  | .bxor (w := w) a b => .bxor (.ofDep w) (Term.ofDepTerm a) (Term.ofDepTerm b)
  | .bnot (w := w) a => .bnot (.ofDep w) (Term.ofDepTerm a)
  | .boolVar v => .boolVar v
  | .boolConst b => .boolConst b
  | .shiftl (w := w) a k => .shiftl (.ofDep w) (Term.ofDepTerm a) k
  | .setWidth a wnew => .setWidth (Term.ofDepTerm a) (.ofDep wnew)
  | .bvOfBool b => .bvOfBool (Term.ofDepTerm b)
  | .binWidthRel k wa wb => .binWidthRel k (.ofDep wa) (.ofDep wb)
  | .binRel k w a b => .binRel k (.ofDep w)
      (Term.ofDepTerm a) (Term.ofDepTerm b)
  | .and p1 p2 => .and (Term.ofDepTerm p1) (Term.ofDepTerm p2)
  | .or p1 p2 => .or (Term.ofDepTerm p1) (Term.ofDepTerm p2)
  | .boolBinRel k a b => .boolBinRel k (Term.ofDepTerm a) (Term.ofDepTerm b)
  | .pvar v => .pvar v

@[simp]
def Term.ofDep_var {wcard tcard : Nat} (bcard : Nat) (ncard : Nat) (icard : Nat) (pcard : Nat)
    {v : Fin tcard} {tctx : Term.Ctx wcard tcard} :
    Term.ofDepTerm (wcard := wcard) (tcard := tcard) (bcard := bcard) (ncard := ncard) (icard := icard) (pcard := pcard) (tctx := tctx)
    (MultiWidth.Term.var v) = Term.var v (.ofDep (tctx v)) := rfl

def Term.width (t : Term) : WidthExpr :=
  match t with
--  | .ofBool _b => WidthExpr.const 1
  | .ofNat w _n => w
  | .var _v w => w
  | .add w _a _b => w
  | .zext _a wnew => wnew
  | .setWidth _a wnew => wnew
  | .sext _a wnew => wnew
  | .bor w _a _b => w
  | .band w _a _b => w
  | .bxor w _a _b => w
  | .bnot w _a => w
  | .boolVar _v => WidthExpr.const 1 -- dummy width.
  | .boolConst _b => WidthExpr.const 1
  | .shiftl w _a _k => w
  | .bvOfBool _b => WidthExpr.const 1
  | binWidthRel _k wa wb => WidthExpr.const 0
  | binRel _k w _a _b => w
  | or _p1 _p2 => WidthExpr.const 0
  | and _p1 _p2 => WidthExpr.const 0
  | pvar _v => WidthExpr.const 0
  | boolBinRel _k _a _b => WidthExpr.const 0

/-- The width of the non-dependently typed 't' equals the width 'w',
converting into the non-dependent version. -/
@[simp]
theorem Term.width_ofDep_eq_ofDep {wcard tcard : Nat} (bcard : Nat)
    {w : MultiWidth.WidthExpr wcard}
    {tctx : Term.Ctx wcard tcard}
    (t : MultiWidth.Term bcard ncard icard pcard tctx (.bv w))
    : (Term.ofDepTerm t).width = (.ofDep w) := by
  cases t <;> simp [Term.ofDepTerm, Term.width]

def Term.wcard (t : Term) : Nat := t.width.wcard

def Term.tcard (t : Term) : Nat :=
  match t with
  | .ofNat _w _n => 0
  | .var v _w => v + 1
  | .add _w a b => max (Term.tcard a) (Term.tcard b)
  | .zext a _wnew => (Term.tcard a)
  | .sext a _wnew => (Term.tcard a)
  | .setWidth a _wnew => (Term.tcard a)
  | .bor _w a b => (max (Term.tcard a) (Term.tcard b))
  | .band _w a b => (max (Term.tcard a) (Term.tcard b))
  | .bxor _w a b => (max (Term.tcard a) (Term.tcard b))
  | .bnot _w a => (Term.tcard a)
  | .boolVar _v => 0
  | .boolConst _b => 0
  | .shiftl _w a _k => (Term.tcard a)
  | bvOfBool b => b.tcard
  | binWidthRel _k _wa _wb => 0
  | binRel _k _w a b => max (Term.tcard a) (Term.tcard b)
  | or p1 p2 => max (Term.tcard p1) (Term.tcard p2)
  | and p1 p2 => max (Term.tcard p1) (Term.tcard p2)
  | pvar _v => 0
  | boolBinRel _k a b => max (a.tcard) (b.tcard)

def Term.bcard (t : Term) : Nat :=
  match t with
  | .ofNat _w _n => 0
  | .var _v _w => 0
  | .add _w a b => max (Term.bcard a) (Term.bcard b)
  | .zext a _wnew => (Term.bcard a)
  | .sext a _wnew => (Term.bcard a)
  | .setWidth a _wnew => (Term.bcard a)
  | .bor _w a b => (max (Term.bcard a) (Term.bcard b))
  | .band _w a b => (max (Term.bcard a) (Term.bcard b))
  | .bxor _w a b => (max (Term.bcard a) (Term.bcard b))
  | .bnot _w a => (Term.bcard a)
  | .boolVar v => v + 1
  | .boolConst _b => 0
  | .shiftl _w a _k => (Term.bcard a)
  | bvOfBool b => b.bcard
  | binWidthRel _k _wa _wb => 0
  | binRel _k _w a b => max (Term.bcard a) (Term.bcard b)
  | or p1 p2 => max (Term.bcard p1) (Term.bcard p2)
  | and p1 p2 => max (Term.bcard p1) (Term.bcard p2)
  | pvar _v => 0
  | boolBinRel _k a b => max (a.bcard) (b.bcard)

end Nondep

section ToFSM


/-- the FSM that corresponds to a given nat-predicate. -/
structure NatFSM (wcard tcard bcard ncard icard pcard : Nat) (v : Nondep.WidthExpr) where
  toFsm : FSM (StateSpace wcard tcard bcard ncard icard pcard)

structure TermFSM (wcard tcard bcard ncard icard pcard : Nat) (t : Nondep.Term) where
  toFsmZext : FSM (StateSpace wcard tcard bcard ncard icard pcard)
  width : NatFSM wcard tcard bcard ncard icard pcard t.width


/--
Preconditions on the environments: 1. The widths are encoded in unary.
-/
structure HWidthEnv {wcard tcard : Nat}
    (fsmEnv : StateSpace wcard tcard bcard ncard icard pcard → BitStream)
    (wenv : Fin wcard → Nat) : Prop where
    heq_width : ∀ (v : Fin wcard),
      fsmEnv (StateSpace.widthVar v) = BitStream.ofNatUnary (wenv v)

noncomputable def BitStream.ofBool (b : Bool) : BitStream := fun _i => b
@[simp]
theorem BitStream.ofBool_eq (b : Bool) : (BitStream.ofBool b i) = b := rfl

/--
Preconditions on the environments: 2. The terms are encoded in binary bitstreams.
-/
structure HTermEnv {wcard tcard bcard : Nat}
    {wenv : Fin wcard → Nat} {tctx : Term.Ctx wcard tcard}
    (fsmEnv : StateSpace wcard tcard bcard ncard icard pcard → BitStream)
    (tenv : tctx.Env wenv)
    (benv : Term.BoolEnv bcard) : Prop
  extends HWidthEnv fsmEnv wenv where
    heq_term : ∀ (v : Fin tcard),
      fsmEnv (StateSpace.termVar v) = BitStream.ofBitVecZext (tenv v)
    heq_bool : ∀ (v : Fin bcard),
      fsmEnv (StateSpace.boolVar v) = BitStream.ofBool (benv v)


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
/-- make a 'HTermEnv' of 'ofTenv'. -/
noncomputable def HTermEnv.mkFsmEnvOfTenv {wcard tcard bcard ncard icard pcard : Nat}
    {wenv : Fin wcard → Nat} {tctx : Term.Ctx wcard tcard}
    (tenv : tctx.Env wenv)
    (benv : Term.BoolEnv bcard)
    (_nenv : Term.NatEnv ncard)
    (_ienv : Term.IntEnv icard)
    (penv : Predicate.Env pcard) :
    StateSpace wcard tcard bcard ncard icard pcard → BitStream := fun
    | .widthVar v =>
        BitStream.ofNatUnary (wenv v)
    | .termVar v =>
      BitStream.ofBitVecZext (tenv v)
    | .predVar v => BitStream.ofProp (penv v)
    | .boolVar v => BitStream.ofBool (benv v) -- dummy value.

@[simp]
theorem HTermEnv.of_mkFsmEnvOfTenv {wcard tcard bcard ncard icard pcard : Nat}
    {wenv : Fin wcard → Nat} {tctx : Term.Ctx wcard tcard}
    (tenv : tctx.Env wenv)
    (benv : Term.BoolEnv bcard)
    (nenv : Term.NatEnv ncard)
    (ienv : Term.IntEnv icard)
    (penv : Predicate.Env pcard) :
    HTermEnv (mkFsmEnvOfTenv tenv benv nenv ienv penv) tenv benv := by
  repeat (constructor <;> try (intros; rfl))

structure HPredicateEnv {wcard tcard bcard ncard icard pcard : Nat}
    (fsmEnv : StateSpace wcard tcard bcard ncard icard pcard → BitStream)
    (penv : Fin pcard → Prop) : Prop where
    heq_width : ∀ (v : Fin pcard),
      fsmEnv (StateSpace.predVar v) = BitStream.ofProp (penv v)

@[simp]
theorem HPredicateEnv.of_mkFsmEnvOfTenv {wcard tcard bcard ncard icard pcard : Nat}
    {wenv : Fin wcard → Nat}
    {tctx : Term.Ctx wcard tcard}
    (tenv : tctx.Env wenv)
    (benv : Term.BoolEnv bcard)
    (nenv : Term.NatEnv ncard)
    (ienv : Term.IntEnv icard)
    (penv : Predicate.Env pcard) :
    HPredicateEnv (HTermEnv.mkFsmEnvOfTenv tenv benv nenv ienv penv) penv := by
  constructor
  intros p
  simp [HTermEnv.mkFsmEnvOfTenv]

structure HNatFSMToBitstream {wcard : Nat} {v : WidthExpr wcard} {tcard : Nat} {bcard : Nat} {pcard : Nat}
   (fsm : NatFSM wcard tcard bcard ncard icard pcard (.ofDep v)) : Prop where
  heq :
    ∀ (wenv : Fin wcard → Nat)
    (fsmEnv : StateSpace wcard tcard bcard ncard icard pcard → BitStream),
    (henv : HWidthEnv fsmEnv wenv) →
      fsm.toFsm.eval fsmEnv =
      BitStream.ofNatUnary (v.toNat wenv)

-- | TODO: Rename to be BV focused.
/--
Our term FSMs start unconditionally with a '0',
and then proceed to produce outputs.
This ensures that the width-0 value is assumed to be '0',
followed by the output at a width 'i'.
-/
structure HTermFSMToBitStream {w : WidthExpr wcard}
  {tctx : Term.Ctx wcard tcard}
  {t : Term bcard ncard icard pcard tctx (.bv w)}
  (fsm : TermFSM wcard tcard bcard ncard icard pcard (.ofDepTerm t)) : Prop where
  heq :
    ∀ {wenv : WidthExpr.Env wcard}
      (benv : Term.BoolEnv bcard)
      (nenv : Term.NatEnv ncard)
      (ienv : Term.IntEnv icard)
      (penv : Predicate.Env pcard) (tenv : tctx.Env wenv)
      (fsmEnv : StateSpace wcard tcard bcard ncard icard pcard → BitStream),
      (henv : HTermEnv fsmEnv tenv benv) →
        fsm.toFsmZext.eval fsmEnv =
        BitStream.ofBitVecZext (t.toBV benv nenv ienv penv tenv)

structure HTermBoolFSMToBitStream
  {tctx : Term.Ctx wcard tcard}
  {t : Term bcard ncard icard pcard tctx .bool}
  (fsm : TermFSM wcard tcard bcard ncard icard pcard (.ofDepTerm t)) : Prop where
  heq :
    ∀ {wenv : WidthExpr.Env wcard}
      (benv : Term.BoolEnv bcard)
      (nenv : Term.NatEnv ncard)
      (ienv : Term.IntEnv icard)
      (penv : Predicate.Env pcard) (tenv : tctx.Env wenv)
      (fsmEnv : StateSpace wcard tcard bcard ncard icard pcard → BitStream),
      (henv : HTermEnv fsmEnv tenv benv) →
        fsm.toFsmZext.eval fsmEnv =
        BitStream.ofBool (t.toBV benv nenv ienv penv tenv) -- TODO: make this exactly the same as predicate?


structure HPredFSMToBitStream {pcard : Nat}
  {tctx : Term.Ctx wcard tcard}
  {p : Term bcard ncard icard pcard tctx .prop}
  (fsm : TermFSM wcard tcard bcard ncard icard pcard
    (.ofDepTerm p)) : Prop where
  heq :
    ∀ {wenv : WidthExpr.Env wcard}
      (benv : Term.BoolEnv bcard)
      (nenv : Term.NatEnv ncard)
      (ienv : Term.IntEnv icard)
      (penv : Predicate.Env pcard) (tenv : tctx.Env wenv)
      (fsmEnv : StateSpace wcard tcard bcard ncard icard pcard → BitStream),
      (htenv : HTermEnv fsmEnv tenv benv) →
      (hpenv : HPredicateEnv fsmEnv penv) →
        p.toBV benv nenv ienv penv tenv  ↔ (fsm.toFsmZext.eval fsmEnv = .negOne)

end ToFSM
end MultiWidth
