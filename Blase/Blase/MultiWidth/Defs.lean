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
/-- multiplication of two terms of the same width -/
| mul (a : Term bcard ncard icard pcard tctx (.bv w))
  (b : Term bcard ncard icard pcard tctx (.bv w)) : Term bcard ncard icard pcard tctx (.bv w)
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


/-- Record whether the term is a linear-bitwise term,
which can be encoded using automata. -/
def Term.isAutomtaDecidable  :
    Term bcard ncard icard pcard tctx k → Bool
| .ofNat _ _ => true
| .boolConst _ => true
| .var _ => true
| .bvOfBool x => x.isAutomtaDecidable
| .or p q => p.isAutomtaDecidable && q.isAutomtaDecidable
| .and p q => p.isAutomtaDecidable && q.isAutomtaDecidable
| .boolVar _ => true
| .binRel _kind _w a b =>
  Term.isAutomtaDecidable a && Term.isAutomtaDecidable b
| .boolBinRel _kind a b =>
  Term.isAutomtaDecidable a && Term.isAutomtaDecidable b
| .add a b => Term.isAutomtaDecidable a && Term.isAutomtaDecidable b
| .zext a _ => Term.isAutomtaDecidable a
| .sext a _ => Term.isAutomtaDecidable a
| .setWidth a _ => Term.isAutomtaDecidable a
| .band a b => Term.isAutomtaDecidable a && Term.isAutomtaDecidable b
| .bor a b => Term.isAutomtaDecidable a && Term.isAutomtaDecidable b
| .bxor a b => Term.isAutomtaDecidable a && Term.isAutomtaDecidable b
| .bnot a => Term.isAutomtaDecidable a
| .shiftl a _ => Term.isAutomtaDecidable a
| .mul _ _ => false
| _ => true


@[simp, grind .]
theorem Term.isAutomataDecidable_add_iff (a b : Term bcard ncard icard pcard tctx (.bv w)) :
    Term.isAutomtaDecidable (.add a b) = true ↔
    Term.isAutomtaDecidable a = true ∧ Term.isAutomtaDecidable b = true := by
  grind [Term.isAutomtaDecidable]

@[simp, grind .]
theorem Term.isAutomataDecidable_zext_iff
    (a : Term bcard ncard icard pcard tctx (.bv w)) :
    Term.isAutomtaDecidable (Term.zext a v) = true ↔
    Term.isAutomtaDecidable a = true := by
  grind [Term.isAutomtaDecidable]

@[simp, grind .]
theorem Term.isAutomataDecidable_setWidth_iff
    (a : Term bcard ncard icard pcard tctx (.bv w)) :
    Term.isAutomtaDecidable (Term.setWidth a v) = true ↔
    Term.isAutomtaDecidable a = true := by
  grind [Term.isAutomtaDecidable]

@[simp, grind .]
theorem Term.isAutomataDecidable_band_iff (a b : Term bcard ncard icard pcard tctx (.bv w)) :
    Term.isAutomtaDecidable (.band a b) = true ↔
    Term.isAutomtaDecidable a = true ∧ Term.isAutomtaDecidable b = true := by
  grind [Term.isAutomtaDecidable]

@[simp, grind .]
theorem Term.isAutomataDecidable_bor_iff (a b : Term bcard ncard icard pcard tctx (.bv w)) :
    Term.isAutomtaDecidable (.bor a b) = true ↔
    Term.isAutomtaDecidable a = true ∧ Term.isAutomtaDecidable b = true := by
  grind [Term.isAutomtaDecidable]

@[simp, grind .]
theorem Term.isAutomataDecidable_bxor_iff (a b : Term bcard ncard icard pcard tctx (.bv w)) :
    Term.isAutomtaDecidable (.bxor a b) = true ↔
    Term.isAutomtaDecidable a = true ∧ Term.isAutomtaDecidable b = true := by
  grind [Term.isAutomtaDecidable]

@[simp, grind .]
theorem Term.isAutomataDecidable_bnot_iff (a : Term bcard ncard icard pcard tctx (.bv w)) :
    Term.isAutomtaDecidable (.bnot a) = true ↔
    Term.isAutomtaDecidable a = true := by
  grind [Term.isAutomtaDecidable]

@[simp, grind .]
theorem Term.isAutomataDecidable_shiftl_iff (a : Term bcard ncard icard pcard tctx (.bv w)) :
    Term.isAutomtaDecidable (.shiftl a k) = true ↔
    Term.isAutomtaDecidable a = true := by
  grind [Term.isAutomtaDecidable]

@[simp, grind .]
theorem Term.isLinearBitwise_mul_eq_false
  (a b : Term bcard ncard icard pcard tctx (.bv w)) :
    Term.isAutomtaDecidable (.mul a b) = false := rfl


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
| .mul (w := w) a b =>
    let a : BitVec (w.toNat wenv) := (a.toBV benv nenv ienv penv tenv)
    let b : BitVec (w.toNat wenv) := (b.toBV benv nenv ienv penv tenv)
    a * b
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

@[simp]
theorem Term.toBV_ofNat
    {tctx : Term.Ctx wcard tcard}
    (tenv : tctx.Env wenv)
    (benv : Term.BoolEnv bcard)
    (_nnenv : Term.NatEnv ncard)
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
| mul (w : WidthExpr) (a b : Term) : Term
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
| shiftr (w : WidthExpr) (a : Term) (k : Nat) : Term
| bvOfBool (b : Term) : Term
| binWidthRel (k : WidthBinaryRelationKind) (wa wb : WidthExpr) : Term
| binRel (k : BinaryRelationKind) (w : WidthExpr)
    (a : Term) (b : Term) : Term
| or (p1 p2 : Term) : Term
| and (p1 p2 : Term) : Term
| pvar (v : Nat) : Term
| pTrue : Term
| pFalse : Term
| boolBinRel (k : BoolBinaryRelationKind)
    (a b : Term) : Term
| udiv (w : WidthExpr) (a b : Term) : Term       -- unsigned division
| urem (w : WidthExpr) (a b : Term) : Term       -- unsigned remainder
| vlshr (w : WidthExpr) (a b : Term) : Term      -- variable logical right shift
| vashr (w : WidthExpr) (a b : Term) : Term      -- variable arithmetic right shift
| vshl (w : WidthExpr) (a b : Term) : Term       -- variable left shift
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
| .udiv .. | .urem .. | .vlshr .. | .vashr .. | .vshl .. => .junk "non-automata-bv"
| _ => .junk "predicate"

/-- Negate a predicate term by pushing `not` inward via De Morgan's laws.
    Returns `none` if the term cannot be negated (e.g., unrecognized atomic terms or
    width relations whose negations cannot be expressed in the Term language). -/
def Term.pnegate (t : Term) : Term × Bool :=
  match t with
  | .and p q =>
    let (p', result) := p.pnegate
    let (q', result') := q.pnegate
    (.or p' q', result && result')
  | .or p q =>
    let (p', result) := p.pnegate
    let (q', result') := q.pnegate
    (.and p' q', result && result')
  | .binRel .eq w a b => (.binRel .ne w a b, true)
  | .binRel .ne w a b => (.binRel .eq w a b, true)
  | .binRel .ult w a b => (.binRel .ule w b a, true)
  | .binRel .ule w a b => (.binRel .ult w b a, true)
  | .binRel .slt w a b => (.binRel .sle w b a, true)
  | .binRel .sle w a b => (.binRel .slt w b a, true)
  | .pTrue => (.pFalse, true)
  -- ¬(wa ≤ wb) ↔ wb + 1 ≤ wa (i.e., wa > wb, since these are naturals)
  | .binWidthRel .le wa wb => (.binWidthRel .le (.addK wb 1) wa, true)
  -- ¬(wa = wb) ↔ wa < wb ∨ wb < wa ↔ (wa+1 ≤ wb) ∨ (wb+1 ≤ wa)
  | .binWidthRel .eq wa wb =>
    (.or (.binWidthRel .le (.addK wa 1) wb) (.binWidthRel .le (.addK wb 1) wa), true)
  | .pFalse => (.pTrue, true)
  | .boolBinRel .. | .pvar .. | .bvOfBool ..
    | .shiftr .. | .shiftl .. | .boolConst .. | .boolVar ..
    | .bnot .. | .bxor .. | .band .. | .bor .. | .setWidth .. | .sext .. | .zext ..
    | .mul .. | .add .. | .var .. | .ofNat ..
    | .udiv .. | .urem .. | .vlshr .. | .vashr .. | .vshl .. =>
    dbg_trace "ERROR: could not negate term {repr t}"; (t, false)

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
  | .mul (w := w) a b => .mul (.ofDep w) (Term.ofDepTerm a) (Term.ofDepTerm b)
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
    {tctx : Term.Ctx wcard tcard}
    {v : Fin tcard} :
    Term.ofDepTerm (wcard := wcard) (tcard := tcard) (bcard := bcard) (ncard := ncard) (icard := icard) (pcard := pcard) (tctx := tctx)
    (MultiWidth.Term.var v) = Term.var v (.ofDep (tctx v)) := rfl

@[simp]
theorem Term.ofDep_add {wcard tcard : Nat} (bcard : Nat) (ncard : Nat) (icard : Nat) (pcard : Nat)
    {tctx : Term.Ctx wcard tcard}
    {w : MultiWidth.WidthExpr wcard}
    {a b : MultiWidth.Term bcard ncard icard pcard tctx (.bv w)}  :
    Term.ofDepTerm (MultiWidth.Term.add (w := w) a b) =
      Term.add (.ofDep w) (Term.ofDepTerm a) (Term.ofDepTerm b) := rfl

def Term.width (t : Term) : WidthExpr :=
  match t with
--  | .ofBool _b => WidthExpr.const 1
  | .ofNat w _n => w
  | .var _v w => w
  | .add w _a _b => w
  | .mul w _a _b => w
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
  | .shiftr w _a _k => w
  | .bvOfBool _b => WidthExpr.const 1
  | binWidthRel _k _wa _wb => WidthExpr.const 0
  | binRel _k w _a _b => w
  | or _p1 _p2 => WidthExpr.const 0
  | and _p1 _p2 => WidthExpr.const 0
  | pTrue => WidthExpr.const 0
  | pFalse => WidthExpr.const 0
  | pvar _v => WidthExpr.const 0
  | boolBinRel _k _a _b => WidthExpr.const 0
  | udiv w _a _b => w
  | urem w _a _b => w
  | vlshr w _a _b => w
  | vashr w _a _b => w
  | vshl w _a _b => w

/-- The width of the non-dependently typed 't' equals the width 'w',
converting into the non-dependent version. -/
@[simp]
theorem Term.width_ofDep_eq_ofDep {wcard tcard : Nat} (bcard : Nat)
    {w : MultiWidth.WidthExpr wcard}
    {tctx : Term.Ctx wcard tcard}
    (t : MultiWidth.Term bcard ncard icard pcard tctx (.bv w))
    : (Term.ofDepTerm t).width = (.ofDep w) := by
  cases t <;> simp [Term.ofDepTerm, Term.width]

/--
the width cardinality of this term's width.
-/
def Term.wcard (t : Term) : Nat := t.width.wcard

/--
The maximum width cardinality of this entire term's subtree.
-/
def Term.maxwcard (t : Term) : Nat :=
  match t with
  | .ofNat w _ => w.wcard
  | .var _ w => w.wcard
  | .add w a b => max w.wcard (max (Term.maxwcard a) (Term.maxwcard b))
  | .mul w a b => max w.wcard (max (Term.maxwcard a) (Term.maxwcard b))
  | .zext a wnew => max (Term.maxwcard a) wnew.wcard
  | .sext a wnew => max (Term.maxwcard a) wnew.wcard
  | .setWidth a wnew => max (Term.maxwcard a) wnew.wcard
  | .bor w a b => max w.wcard (max (Term.maxwcard a) (Term.maxwcard b))
  | .band w a b => max w.wcard (max (Term.maxwcard a) (Term.maxwcard b))
  | .bxor w a b => max w.wcard (max (Term.maxwcard a) (Term.maxwcard b))
  | .bnot w a => max w.wcard (Term.maxwcard a)
  | .boolVar _ => 0
  | .boolConst _ => 0
  | .shiftl w a _ => max w.wcard (Term.maxwcard a)
  | .shiftr w a _ => max w.wcard (Term.maxwcard a)
  | .bvOfBool _ => 0
  | binWidthRel _k wa wb => max wa.wcard wb.wcard
  | binRel _k w a b => max w.wcard (max (Term.maxwcard a) (Term.maxwcard b))
  | or p1 p2 => max (Term.maxwcard p1) (Term.maxwcard p2)
  | and p1 p2 => max (Term.maxwcard p1) (Term.maxwcard p2)
  | pTrue => 0
  | pFalse => 0
  | pvar _ => 0
  | boolBinRel _k a b => max (Term.maxwcard a) (Term.maxwcard b)
  | udiv w a b => max w.wcard (max (Term.maxwcard a) (Term.maxwcard b))
  | urem w a b => max w.wcard (max (Term.maxwcard a) (Term.maxwcard b))
  | vlshr w a b => max w.wcard (max (Term.maxwcard a) (Term.maxwcard b))
  | vashr w a b => max w.wcard (max (Term.maxwcard a) (Term.maxwcard b))
  | vshl w a b => max w.wcard (max (Term.maxwcard a) (Term.maxwcard b))

def Term.tcard (t : Term) : Nat :=
  match t with
  | .ofNat _w _n => 0
  | .var v _w => v + 1
  | .add _w a b => max (Term.tcard a) (Term.tcard b)
  | .mul _w a b => max (Term.tcard a) (Term.tcard b)
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
  | .shiftr _w a _k => (Term.tcard a)
  | bvOfBool b => b.tcard
  | binWidthRel _k _wa _wb => 0
  | binRel _k _w a b => max (Term.tcard a) (Term.tcard b)
  | or p1 p2 => max (Term.tcard p1) (Term.tcard p2)
  | and p1 p2 => max (Term.tcard p1) (Term.tcard p2)
  | pTrue => 0
  | pFalse => 0
  | pvar _v => 0
  | boolBinRel _k a b => max (a.tcard) (b.tcard)
  | udiv _w a b => max (Term.tcard a) (Term.tcard b)
  | urem _w a b => max (Term.tcard a) (Term.tcard b)
  | vlshr _w a b => max (Term.tcard a) (Term.tcard b)
  | vashr _w a b => max (Term.tcard a) (Term.tcard b)
  | vshl _w a b => max (Term.tcard a) (Term.tcard b)

def Term.bcard (t : Term) : Nat :=
  match t with
  | .ofNat _w _n => 0
  | .var _v _w => 0
  | .add _w a b => max (Term.bcard a) (Term.bcard b)
  | .mul _w a b => max (Term.bcard a) (Term.bcard b)
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
  | .shiftr _w a _k => (Term.bcard a)
  | bvOfBool b => b.bcard
  | binWidthRel _k _wa _wb => 0
  | binRel _k _w a b => max (Term.bcard a) (Term.bcard b)
  | or p1 p2 => max (Term.bcard p1) (Term.bcard p2)
  | and p1 p2 => max (Term.bcard p1) (Term.bcard p2)
  | pTrue => 0
  | pFalse => 0
  | pvar _v => 0
  | boolBinRel _k a b => max (a.bcard) (b.bcard)
  | udiv _w a b => max (Term.bcard a) (Term.bcard b)
  | urem _w a b => max (Term.bcard a) (Term.bcard b)
  | vlshr _w a b => max (Term.bcard a) (Term.bcard b)
  | vashr _w a b => max (Term.bcard a) (Term.bcard b)
  | vshl _w a b => max (Term.bcard a) (Term.bcard b)

/-- Returns true if the term can be decided by the automata-based procedure.
Multiplication is NOT automata decidable. -/
def Term.isAutomtaDecidable : Term → Bool
| .ofNat _ _ => true
| .var _ _ => true
| .add _ a b => a.isAutomtaDecidable && b.isAutomtaDecidable
| .mul _ _ _ => false
| .zext a _ => a.isAutomtaDecidable
| .setWidth a _ => a.isAutomtaDecidable
| .sext a _ => a.isAutomtaDecidable
| .bor _ a b => a.isAutomtaDecidable && b.isAutomtaDecidable
| .band _ a b => a.isAutomtaDecidable && b.isAutomtaDecidable
| .bxor _ a b => a.isAutomtaDecidable && b.isAutomtaDecidable
| .bnot _ a => a.isAutomtaDecidable
| .boolVar _ => true
| .boolConst _ => true
| .shiftl _ a _ => a.isAutomtaDecidable
| .shiftr .. => false -- TODO: this is not automata decidable.
| .bvOfBool b => b.isAutomtaDecidable
| .binWidthRel _ _ _ => true
| .binRel _ _ a b => a.isAutomtaDecidable && b.isAutomtaDecidable
| .or p1 p2 => p1.isAutomtaDecidable && p2.isAutomtaDecidable
| .and p1 p2 => p1.isAutomtaDecidable && p2.isAutomtaDecidable
| .pTrue => true
| .pFalse => false -- Even though theoreitcally it is, we don't implement it right now.
| .pvar _ => true
| .boolBinRel _ a b => a.isAutomtaDecidable && b.isAutomtaDecidable
| .udiv .. | .urem .. | .vlshr .. | .vashr .. | .vshl .. => false

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
      (hautomata : t.isAutomtaDecidable) →
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
      (hautomata : t.isAutomtaDecidable) →
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
      (hautomata : p.isAutomtaDecidable) →
        p.toBV benv nenv ienv penv tenv  ↔ (fsm.toFsmZext.eval fsmEnv = .negOne)

end ToFSM

section ToSingleWidth

inductive SingleWidthTermKind
| prop
| bv
deriving Inhabited, Repr, Hashable, DecidableEq, Lean.ToExpr


inductive SingleWidthTerm (wcard tcard : Nat) : SingleWidthTermKind → Type where
| wvar : Nat → SingleWidthTerm wcard tcard .bv
| bvvar : Nat → SingleWidthTerm wcard tcard .bv
| bvconst : Nat → SingleWidthTerm wcard tcard .bv
| bvmul (a b : SingleWidthTerm wcard tcard .bv)  : SingleWidthTerm wcard tcard .bv
| bvadd (a b : SingleWidthTerm wcard tcard .bv) : SingleWidthTerm wcard tcard .bv
| bvand (a b : SingleWidthTerm wcard tcard .bv) : SingleWidthTerm wcard tcard .bv
| bvnot (a : SingleWidthTerm wcard tcard .bv) : SingleWidthTerm wcard tcard .bv
| bvule (a b : SingleWidthTerm wcard tcard .bv) : SingleWidthTerm wcard tcard .prop
| bvult (a b : SingleWidthTerm wcard tcard .bv) : SingleWidthTerm wcard tcard .prop
| bveq (a b : SingleWidthTerm wcard tcard .bv) : SingleWidthTerm wcard tcard .prop
| bvne (a b : SingleWidthTerm wcard tcard .bv) : SingleWidthTerm wcard tcard .prop
| propimp (a b : SingleWidthTerm wcard tcard .prop) : SingleWidthTerm wcard tcard .prop
| proptrue : SingleWidthTerm wcard tcard .prop
| unknown : SingleWidthTerm wcard tcard k
deriving Repr, Hashable, DecidableEq, Lean.ToExpr



/--
Environment for single-width terms, mapping width variables to their corresponding width bitvectors.
-/
def SingleWidthTerm.WidthEnv (wcard : Nat) (wout : Nat) : Type :=
  Fin wcard → BitVec wout

/--
Environment for single-width terms, mapping term variables to bitvectors.
-/
def SingleWidthTerm.BVEnv (tcard : Nat) (wout : Nat) : Type :=
  Fin tcard → BitVec wout


def SingleWidthTerm.toBV
  {wcard tcard : Nat}
  (o : Nat)
  (t : SingleWidthTerm wcard tcard .bv)
  (wenv : SingleWidthTerm.WidthEnv wcard o)
  (bvenv : SingleWidthTerm.BVEnv tcard o)
  : BitVec o :=
  match t with
  | .wvar v =>
    if hv : v < wcard
    then wenv ⟨v, hv⟩
    else 0#o -- dummy value
  -- | .wconst c => BitVec.ofNat o c
  | .bvvar v =>
    if hv : v < tcard
    then bvenv ⟨v, hv⟩
    else 0#o -- dummy value
  | .bvconst c => BitVec.ofNat o c
  | .bvnot a => ~~~(a.toBV o wenv bvenv)
  | .bvmul a b =>
    (a.toBV o wenv bvenv) * (b.toBV o wenv bvenv)
  | .bvadd a b => (a.toBV o wenv bvenv) + (b.toBV o wenv bvenv)
  | .bvand a b => (a.toBV o wenv bvenv) &&& (b.toBV o wenv bvenv)
  | .unknown => 0#o-- dummy value

@[simp]
theorem SingleWidthTerm.toBV_wvar {wcard tcard : Nat} {o : Nat}
    (wenv : SingleWidthTerm.WidthEnv wcard o)
    (bvenv : SingleWidthTerm.BVEnv tcard o)
    {v : Nat} :
    SingleWidthTerm.toBV o (.wvar v) wenv bvenv =
    (if hv : v < wcard then wenv ⟨v, hv⟩ else 0#o) := by grind [toBV]

@[simp]
theorem SingleWidthTerm.toBV_bvvar {wcard tcard : Nat} {o : Nat}
    (wenv : SingleWidthTerm.WidthEnv wcard o)
    (bvenv : SingleWidthTerm.BVEnv tcard o)
    {v : Nat} :
    SingleWidthTerm.toBV o (.bvvar v) wenv bvenv =
    (if hv : v < tcard then bvenv ⟨v, hv⟩ else 0#o) := by grind [toBV]

@[simp]
theorem SingleWidthTerm.toBV_bvconst {wcard tcard : Nat} {o : Nat}
    (wenv : SingleWidthTerm.WidthEnv wcard o)
    (bvenv : SingleWidthTerm.BVEnv tcard o)
    {c : Nat} :
    SingleWidthTerm.toBV o (.bvconst c) wenv bvenv =
    BitVec.ofNat o c := by grind [toBV]

@[simp]
theorem SingleWidthTerm.toBV_bvnot {wcard tcard : Nat} {o : Nat}
    (wenv : SingleWidthTerm.WidthEnv wcard o)
    (bvenv : SingleWidthTerm.BVEnv tcard o)
    {a : SingleWidthTerm wcard tcard .bv} :
    SingleWidthTerm.toBV o (.bvnot a) wenv bvenv =
    ~~~(a.toBV o wenv bvenv) := by grind [toBV]

@[simp]
theorem SingleWidthTerm.toBV_bvand {wcard tcard : Nat} {o : Nat}
    (wenv : SingleWidthTerm.WidthEnv wcard o)
    (bvenv : SingleWidthTerm.BVEnv tcard o)
    {a b : SingleWidthTerm wcard tcard .bv} :
    SingleWidthTerm.toBV o (.bvand a b) wenv bvenv =
    (a.toBV o wenv bvenv) &&& (b.toBV o wenv bvenv) := by grind [toBV]

@[simp]
theorem SingleWidthTerm.toBV_bvadd {wcard tcard : Nat} {o : Nat}
    (wenv : SingleWidthTerm.WidthEnv wcard o)
    (bvenv : SingleWidthTerm.BVEnv tcard o)
    {a b : SingleWidthTerm wcard tcard .bv} :
    SingleWidthTerm.toBV o (.bvadd a b) wenv bvenv =
    (a.toBV o wenv bvenv) + (b.toBV o wenv bvenv) := by grind [toBV]

def SingleWidthTerm.toProp
  {wcard tcard : Nat}
  (o : Nat)
  (t : SingleWidthTerm wcard tcard .prop)
  (wenv : SingleWidthTerm.WidthEnv wcard o)
  (bvenv : SingleWidthTerm.BVEnv tcard o) : Prop :=
  match t with
  | .bvule a b => (a.toBV o wenv bvenv).ule (b.toBV o wenv bvenv)
  | .bvult a b => (a.toBV o wenv bvenv).ult (b.toBV o wenv bvenv)
  | .bveq a b => (a.toBV o wenv bvenv) = (b.toBV o wenv bvenv)
  | .bvne a b => (a.toBV o wenv bvenv) ≠ (b.toBV o wenv bvenv)
  | .propimp a b => (a.toProp o wenv bvenv) → (b.toProp o wenv bvenv)
  | .proptrue => True
  | .unknown => False

-- -b = !b + 1
def SingleWidthTerm.bvneg (t : SingleWidthTerm wcard tcard .bv) : SingleWidthTerm wcard tcard .bv :=
  .bvadd (.bvnot t) (.bvconst 1)

def SingleWidthTerm.bvsub (t1 t2 : SingleWidthTerm wcard tcard .bv) : SingleWidthTerm wcard tcard .bv :=
  .bvadd t1 (SingleWidthTerm.bvneg t2)

-- power of 2 - 1 = unary mask.
def SingleWidthTerm.maskOfPot (w : SingleWidthTerm wcard tcard .bv) : SingleWidthTerm wcard tcard .bv :=
  (SingleWidthTerm.bvsub w (.bvconst 1))

namespace Nondep

/--
Convert a width expression to its corresponding single-width term.
This is used to convert the width expressions with multiple widths into a single-width expression.
-/
def WidthExpr.toSingleWidthTerm (wcard tcard : Nat) (w : WidthExpr) : SingleWidthTerm wcard tcard .bv :=
  match w with
  | .const c => .bvconst (1 <<< c)
  | .var v => (.wvar (v))
  | _ => .unknown

@[simp]
theorem WidthExpr.toSingleWidthTerm_const {wcard tcard : Nat} {c : Nat} :
    WidthExpr.toSingleWidthTerm wcard tcard (WidthExpr.const c) = .bvconst (1 <<< c) := rfl

@[simp]
theorem WidthExpr.toSingleWidthTerm_var {wcard tcard : Nat} {v : Nat} :
    WidthExpr.toSingleWidthTerm wcard tcard (WidthExpr.var v) = .wvar v := rfl


/--
Convert a term to its corresponding single-width term.
TODO: Change the type to `SingleWidthTerm × Bool`, and drop `.unknown : SingleWidthTerm`.
This will cleanup the implementation, and we don't need `isTranslated` or whaetver.
-/
def Term.toSingleWidthTerm (wcard tcard : Nat)  (t : Term) : SingleWidthTerm wcard tcard .bv :=
  match t with
  | .var v _w => .bvvar v
  | .add w a b =>
    let aMono := a.toSingleWidthTerm wcard tcard
    let bMono := b.toSingleWidthTerm wcard tcard
    let wMono := w.toSingleWidthTerm wcard tcard
    .bvand (.bvadd aMono bMono) wMono
  | .band _w a b =>
    let aMono := a.toSingleWidthTerm wcard tcard
    let bMono := b.toSingleWidthTerm wcard tcard
    .bvand aMono bMono
  | _ => .unknown

@[simp]
theorem Term.toSingleWidthTerm_var {wcard tcard : Nat}
    {v : Fin tcard} {tctx : Term.Ctx wcard tcard} :
    Term.toSingleWidthTerm wcard tcard (Term.var v (.ofDep (tctx v))) = .bvvar v := rfl

@[simp]
theorem Term.toSingleWidthTerm_add {wcard tcard : Nat}
    {w : MultiWidth.WidthExpr wcard}
    {a b : Term} :
    Term.toSingleWidthTerm wcard tcard (Term.add (.ofDep w) a b) =
    .bvand (.bvadd (Term.toSingleWidthTerm wcard tcard a) (Term.toSingleWidthTerm wcard tcard b))
      (WidthExpr.toSingleWidthTerm wcard tcard (.ofDep w)) := rfl

end Nondep

/-- -x = !x + 1 -/
def SingleWidthTerm.neg {wcard tcard : Nat} (t : SingleWidthTerm wcard tcard .bv) : SingleWidthTerm wcard tcard .bv :=
  .bvadd (.bvnot t) (.bvconst 1)

-- x - y = x + (-y)
def SingleWidthTerm.sub {wcard tcard : Nat} (t1 t2 : SingleWidthTerm wcard tcard .bv) : SingleWidthTerm wcard tcard .bv :=
  .bvadd t1 (SingleWidthTerm.neg t2)


-- v & (v - 1) = 0
def SingleWidthTerm.monoIsPotPred (wcard tcard : Nat) (w : SingleWidthTerm wcard tcard .bv) : SingleWidthTerm wcard tcard .prop :=
  .bveq (.bvand w (SingleWidthTerm.sub w (.bvconst 1))) (.bvconst 0)

  -- let var := Term.monoPotVar wcard tcard w
  -- (.band .monoWidth var (Term.potToMask var))

def SingleWidthTerm.mkPotPreconditions (wcard tcard : Nat) (w : Nat) :
    SingleWidthTerm wcard tcard .prop :=
  match w with
  | 0 => .proptrue
  | w' + 1 =>
    .propimp (SingleWidthTerm.monoIsPotPred wcard tcard (.bvconst w)) (SingleWidthTerm.mkPotPreconditions wcard tcard w')


namespace Nondep
def Term.toSingleWidthProp (wcard tcard : Nat) (t : Term) : SingleWidthTerm wcard tcard .prop :=
  match t with
  | .boolConst b => if b then .proptrue else .unknown
  | .binRel k _w a b => -- these are guaranteed to be masked correctly.
    let aMono := a.toSingleWidthTerm wcard tcard
    let bMono := b.toSingleWidthTerm wcard tcard
    match k with
    | .ule => .bvule aMono bMono
    | .ult => .bvult aMono bMono
    | .eq => .bveq aMono bMono
    | .ne => .bvne aMono bMono
    | _ => .unknown
  | _ => .unknown

end Nondep

namespace Nondep
open Std.Tactic.BVDecide

/-- Evaluate a width expression to a concrete `Nat` given a width variable assignment. -/
def WidthExpr.eval (wenv : Array Nat) : WidthExpr → Nat
  | .const c => c
  | .var v => wenv[v]?.getD 0
  | .max a b => (Nat.max (a.eval wenv) (b.eval wenv))
  | .min a b => (Nat.min (a.eval wenv) (b.eval wenv))
  | .addK a k =>((a.eval wenv) + k)
  | .kadd k a =>(k + (a.eval wenv))

def _root_.Std.Tactic.BVDecide.BVExpr.width (_ : BVExpr w) : Nat := w

def _root_.Std.Tactic.BVDecide.BVExpr.castAux (x : BVExpr w) (hw : w = w') : BVExpr w' := hw ▸ x

@[implemented_by _root_.Std.Tactic.BVDecide.BVExpr.castAux]
def _root_.Std.Tactic.BVDecide.BVExpr.cast (x : BVExpr w) (hw : w = w') : BVExpr w' :=
  match x with
  | .var v => .var v
  | .const b => .const <| b.cast hw
  | .extract start len x (w := wx) => .extract start w' x
  | .bin a k b => .bin (a.cast hw) k (b.cast hw)
  | .un k x => .un k (x.cast hw)
  | .append x y h => .append x y (by grind)
  | .replicate n x h => .replicate n x (by grind)
  | .shiftLeft x y => .shiftLeft (x.cast hw) y
  | .shiftRight x y => .shiftRight (x.cast hw) y
  | .arithShiftRight x y => .arithShiftRight (x.cast hw) y


def _root_.Std.Tactic.BVDecide.BVExpr.zeroExtend (x : BVExpr w) (wnew : Nat) : BVExpr wnew :=
   if hw : wnew ≤ w then
     .extract 0 wnew x
    else
      .append (BVExpr.const (BitVec.ofNat (wnew - w) 0)) x (by grind)

def _root_.Std.Tactic.BVDecide.BVExpr.msb (x : BVExpr w) : BVExpr 1 :=
  .extract (w - 1) 1 x

def _root_.Std.Tactic.BVDecide.BVExpr.signExtend (x : BVExpr w) (wnew : Nat) : BVExpr wnew :=
  if hw : wnew ≤ w then
    .extract 0 wnew x
  else
    let msb := x.msb
    let ext : BVExpr (wnew - w) := .replicate (wnew - w) msb (by grind)
    .append ext x (by grind)

/-- Convert a BV-producing `Nondep.Term` to a `BVExpr` at monomorphization width `w`.
`wenv` provides concrete width assignments for width variables.
Returns 'true' if the translation succeeded.
-/
def Term.toBVExpr (wenv : Array Nat) (t : Term) : (BVExpr (t.width.eval wenv)) × Bool :=
   match _ht : t with
  | .var v _ => (BVExpr.var v, true)
  | .ofNat w n => (.const (BitVec.ofNat (w.eval wenv) n), true)
  | .add we a b =>
    let (a', aresult) := a.toBVExpr wenv
    let (b', bresult) := b.toBVExpr wenv
    let w := we.eval wenv
    if ha : a'.width = w then
      if hb : b'.width = w then
         if aresult && bresult then
          (.bin (a'.cast ha) .add (b'.cast hb), true)
        else (.const (88#_), false)
      else (.const (88#_), false)
    else (.const (88#_), false)
  | .mul we a b =>
    let (a', aresult) := a.toBVExpr wenv
    let (b', bresult) := b.toBVExpr wenv
    let w := we.eval wenv
    if ha : a'.width = w then
      if hb : b'.width = w then
        if aresult && bresult then
          (.bin (a'.cast ha) .mul (b'.cast hb), true)
        else (.const (88#_), false)
      else (.const (88#_), false)
    else (.const (88#_), false)
  | .band we a b =>
    let (a', aresult) := a.toBVExpr wenv
    let (b', bresult) := b.toBVExpr wenv
    let w := we.eval wenv
    if ha : a'.width = w then
      if hb : b'.width = w then
        if aresult && bresult then
          (.bin (a'.cast ha) .and (b'.cast hb), true)
        else (.const (88#_), false)
      else (.const (88#_), false)
    else (.const (88#_), false)
  | .bor we a b =>
    let (a', aresult) := a.toBVExpr wenv
    let (b', bresult) := b.toBVExpr wenv
    let w := we.eval wenv
    if ha : a'.width = w then
      if hb : b'.width = w then
        if aresult && bresult then
          (.bin (a'.cast ha) .or (b'.cast hb), true)
        else (.const (88#_), false)
      else (.const (88#_), false)
    else (.const (88#_), false)
  | .bxor we a b =>
    let (a', aresult) := a.toBVExpr wenv
    let (b', bresult) := b.toBVExpr wenv
    let w := we.eval wenv
    if ha : a'.width = w then
      if hb : b'.width = w then
        if aresult && bresult then
          (.bin (a'.cast ha) .xor (b'.cast hb), true)
        else (.const (88#_), false)
      else (.const (88#_), false)
    else (.const (88#_), false)
  | .bnot we a =>
    let (a', aresult) := a.toBVExpr wenv
    let w := we.eval wenv
    if ha : a'.width = w then
      if aresult then
        (.un .not (a'.cast ha), true)
      else (.const (89#_), false)
    else (.const (90#_), false)
  | .shiftl we a k =>
    let (a', aresult) := a.toBVExpr wenv
    let w := we.eval wenv
    if ha : a'.width = w then
      if aresult then
        (.shiftLeft (a'.cast ha) (.const (BitVec.ofNat w k)), true)
      else (.const (88#_), false)
    else (.const (88#_), false)
  | .shiftr w a k =>
    let (a', aresult) := a.toBVExpr wenv
    let w := w.eval wenv
    if ha : a'.width = w then
      if aresult then
        (.shiftRight (a'.cast ha) (.const (BitVec.ofNat w k)), true)
      else (.const (88#_), false)
    else (.const (88#_), false)
  | .zext x we =>
    let (x', xresult) := x.toBVExpr wenv
    let w := we.eval wenv
    if xresult then
      (BVExpr.zeroExtend x' w, true)
    else (.const (88#_), false)
  | .sext x we =>
    let (x', xresult) := x.toBVExpr wenv
    let w := we.eval wenv
    if xresult then
      (BVExpr.signExtend x' w, true)
    else (.const (88#_), false)
  | .udiv we a b =>
    let (a', aresult) := a.toBVExpr wenv
    let (b', bresult) := b.toBVExpr wenv
    let w := we.eval wenv
    if ha : a'.width = w then
      if hb : b'.width = w then
        if aresult && bresult then
          (.bin (a'.cast ha) .udiv (b'.cast hb), true)
        else (.const (88#_), false)
      else (.const (88#_), false)
    else (.const (88#_), false)
  | .urem we a b =>
    let (a', aresult) := a.toBVExpr wenv
    let (b', bresult) := b.toBVExpr wenv
    let w := we.eval wenv
    if ha : a'.width = w then
      if hb : b'.width = w then
        if aresult && bresult then
          (.bin (a'.cast ha) .umod (b'.cast hb), true)
        else (.const (88#_), false)
      else (.const (88#_), false)
    else (.const (88#_), false)
  | .vlshr we a b =>
    let (a', aresult) := a.toBVExpr wenv
    let (b', bresult) := b.toBVExpr wenv
    let w := we.eval wenv
    if ha : a'.width = w then
      if hb : b'.width = w then
        if aresult && bresult then
          (.shiftRight (a'.cast ha) (b'.cast hb), true)
        else (.const (88#_), false)
      else (.const (88#_), false)
    else (.const (88#_), false)
  | .vashr we a b =>
    let (a', aresult) := a.toBVExpr wenv
    let (b', bresult) := b.toBVExpr wenv
    let w := we.eval wenv
    if ha : a'.width = w then
      if hb : b'.width = w then
        if aresult && bresult then
          (.arithShiftRight (a'.cast ha) (b'.cast hb), true)
        else (.const (88#_), false)
      else (.const (88#_), false)
    else (.const (88#_), false)
  | .vshl we a b =>
    let (a', aresult) := a.toBVExpr wenv
    let (b', bresult) := b.toBVExpr wenv
    let w := we.eval wenv
    if ha : a'.width = w then
      if hb : b'.width = w then
        if aresult && bresult then
          (.shiftLeft (a'.cast ha) (b'.cast hb), true)
        else (.const (88#_), false)
      else (.const (88#_), false)
    else (.const (88#_), false)
  | .boolBinRel .. | .pvar .. | .and .. | .or ..| .binRel .. | .binWidthRel ..
    | .bvOfBool .. | .boolConst .. | .boolVar .. | .setWidth ..
    | .pFalse | .pTrue =>
    (.const (88#_), false) -- these are not BV expressions, so we return a dummy value and false to indicate failure.

/-- Convert a predicate-producing `Nondep.Term` to a `BVLogicalExpr`.
`wenv` provides concrete width assignments for width variables.
Uses `Term.toBVExpr` for BV subterms within predicates.
`ule a b` is encoded as `¬(ult b a)`, `ne` as `¬(eq)`.
Returns 'true' if the translation succeeded.
-/
def Term.toBVLogicalExpr (wenv : Array Nat) : Term → BVLogicalExpr × Bool
  | .pTrue => (.const true, true)
  | .boolConst b => (.const b, true)
  | .binRel .eq we a b =>
    let (a', aresult) := a.toBVExpr wenv
    let (b', bresult) := b.toBVExpr wenv
    let w := we.eval wenv
    if ha : a'.width = w then
      if hb : b'.width = w then
        if aresult && bresult then
          (.literal (.bin (a'.cast ha) .eq (b'.cast hb)), true)
        else (dbg_trace "ERROR 1"; .const false, false)
      else (dbg_trace "ERROR 2"; .const false, false)
    else (dbg_trace "ERROR 3"; .const false, false)
  | .binRel .ne we a b =>
    let (a', aresult) := a.toBVExpr wenv
    let (b', bresult) := b.toBVExpr wenv
    let w := we.eval wenv
    if ha : a'.width = w then
      if hb : b'.width = w then
        if aresult && bresult then
          (.not (.literal (.bin (a'.cast ha) .eq (b'.cast hb))), true)
        else (dbg_trace "ERROR 4"; .const false, false)
      else (dbg_trace "ERROR 5"; .const false, false)
    else (dbg_trace "ERROR 6"; .const false, false)
  | .binRel .ult we a b =>
    let (a', aresult) := a.toBVExpr wenv
    let (b', bresult) := b.toBVExpr wenv
    let w := we.eval wenv
    if ha : a'.width = w then
      if hb : b'.width = w then
        if aresult && bresult then
          (.literal (.bin (a'.cast ha) .ult (b'.cast hb)), true)
        else (dbg_trace "ERROR 7"; .const false, false)
      else (dbg_trace "ERROR 8"; .const false, false)
    else (dbg_trace "ERROR 9"; .const false, false)
  | .binRel .ule we a b =>
    let (a', aresult) := a.toBVExpr wenv
    let (b', bresult) := b.toBVExpr wenv
    let w := we.eval wenv
    if ha : a'.width = w then
      if hb : b'.width = w then
        if aresult && bresult then
          (.not (.literal (.bin (b'.cast hb) .ult (a'.cast ha))), true)
        else (dbg_trace "ERROR 10";.const false, false)
      else (dbg_trace "ERROR 11"; .const false, false)
    else (dbg_trace "ERROR 12"; .const false, false)
  | .and p1 p2 =>
    let (p1', p1result) := p1.toBVLogicalExpr wenv
    let (p2', p2result) := p2.toBVLogicalExpr wenv
    if p1result && p2result then
      (.gate .and p1' p2', true)
    else (dbg_trace "ERROR 13"; .const false, false)
  | .or p1 p2 =>
    let (p1', p1result) := p1.toBVLogicalExpr wenv
    let (p2', p2result) := p2.toBVLogicalExpr wenv
    if p1result && p2result then
      (.gate .or p1' p2', true)
    else (dbg_trace "ERROR 14"; .const false, false)
  | .binWidthRel .eq ew1 ew2 =>
    let w1 := ew1.eval wenv
    let w2 := ew2.eval wenv
    (.const (w1 = w2), true)
  | .binWidthRel .le ew1 ew2 =>
    let w1 := ew1.eval wenv
    let w2 := ew2.eval wenv
    (.const (w1 ≤ w2), true)
  | .pFalse => (.const false, true)
  | .pvar .. | .binRel .. | .bvOfBool .. | .shiftr ..
    | .shiftl .. | .boolVar .. | .bnot .. | .bxor .. | .band .. | .bor .. | .sext .. | .setWidth ..
    | .zext .. | .mul .. | .add .. | .ofNat .. | .var .. | .boolBinRel ..
    | .udiv .. | .urem .. | .vlshr .. | .vashr .. | .vshl .. =>
    (dbg_trace "ERROR 15"; .const false, false) -- these are not predicate expressions, so we return a dummy value and false to indicate failure.

end Nondep

/--
Drop this entirely, and rely on the `Bool` in the return type of `Nondep.Term.toSingleWidthTerm` instead.
-/
def SingleWidthTerm.isTranslated {wcard tcard : Nat} (t : SingleWidthTerm wcard tcard k) : Bool :=
  match t with
  | .unknown => false
  | _ => true

/--
Build a single-width width environment from a multi-width environment, such that it
satisfies 'HSingleWidthEnvRelation'.
-/
def SingleWidthTerm.WidthEnv.ofMultiWidth {wcard : Nat} (wMultiEnv : WidthExpr.Env wcard) (o : Nat) :
    SingleWidthTerm.WidthEnv wcard o :=
  fun v => BitVec.ofNat o (1 <<< wMultiEnv v)

@[simp]
def Nondep.Term.constOne (w : WidthExpr) : Term :=
  .ofNat w 1

@[simp]
def Nondep.Term.constZero (w : WidthExpr) : Term :=
  .ofNat w 0

def Nondep.Term.constBad (w : WidthExpr) : Term :=
  .ofNat w 77

/-- Compute `-a`. -/
def Nondep.Term.neg (a : Term) : Term :=
  .add a.width (.constOne a.width) (a.bnot a.width)

/-- Compute `a - b`. -/
def Nondep.Term.sub (w : WidthExpr) (a b : Term) : Term :=
  .add w a (b.neg)

/-- p1 → p2 iff ¬p1 ∨ p2.-/
def Nondep.Term.pimplies (p1 p2 : Nondep.Term) : Nondep.Term × Bool:=
  let (p1, success) := p1.pnegate
  (Nondep.Term.or p1 p2, success)


/-- Compute `a + 1`. -/
def Nondep.Term.succ (a : Term) : Term :=
  .add a.width a (Nondep.Term.constOne a.width)

/-- Compute `a - 1`. -/
def Nondep.Term.pred (a : Term) : Term :=
  .sub a.width a (Nondep.Term.constOne a.width)
/--
Create the width precondition for width variable index 'w',
where all variables are to have universe width 'wo'.
This precondition forces the width variable to be a power of 2 minus one.
Recall that a `power of 2: w & (w - 1) = 0`.
Also see that `unary mask = power of 2 - 1`.
`m = p - 1`
`p = u + 1`
`p & (p - 1) = 0`
`m & (m + 1) = 0`.
This also cleanly handles the case where `u` is `0`, since `u & u + 1 = 0`.
-/
def Term.toSingleWidthNondepTerm.mkWidthPrecond (w : Nat) (wo : Nondep.WidthExpr) : Nondep.Term :=
    let m := Nondep.Term.var w wo
    let mAndMSucc := Nondep.Term.band wo m.succ m
    let rhs := Nondep.Term.constZero wo
    let out := Nondep.Term.binRel .eq wo mAndMSucc rhs
    out
/--
Make all the width preconditions of variables of indices [0..w),
with universe width 'wo'.
-/
def Term.toSingleWidthNondepTerm.mkAllWidthPreconds (wo : Nondep.WidthExpr) (w : Nat) : Nondep.Term :=
  match w with
  | 0 => .pTrue
  | w' + 1 =>
    let precond := Term.toSingleWidthNondepTerm.mkWidthPrecond w' wo
    .and precond (Term.toSingleWidthNondepTerm.mkAllWidthPreconds wo w')


/--
Convert a width variable into a bitvector,
which encodes a mask of the form (1 << w) - 1, where w is the width variable.
-/
def Nondep.WidthExpr.toSingleWidthMaskNondepTerm (w : Nondep.WidthExpr) (wo : Nondep.WidthExpr) : Nondep.Term × Bool :=
  match w with
  | .const c => (Nondep.Term.ofNat wo ((1 <<< c) - 1), true) -- 2^0 = 1
  | .var v => (Nondep.Term.var v wo, true)
  | .max a b =>
    let (a', aresult) := a.toSingleWidthMaskNondepTerm wo
    let (b', bresult) := b.toSingleWidthMaskNondepTerm wo
    if aresult && bresult then
      (.bor wo a' b', true) -- mask of max is the and of masks.
    else (.constBad wo, false)
  | .min a b =>
    let (a', aresult) := a.toSingleWidthMaskNondepTerm wo
    let (b', bresult) := b.toSingleWidthMaskNondepTerm wo
    if aresult && bresult then
      (.band wo a' b', true) -- mask of min is the and of masks.
    else (.constBad wo, false)
  | .addK a k =>
    let (amask, aresult) := a.toSingleWidthMaskNondepTerm wo
    if aresult then
      -- consider computing the power of two as 'amask ^ (amask <<< 1)`,
      -- which should be cheaper as it does not need the ripple of the add.
      ((amask.succ.shiftl wo k).pred, true)
    else (.constBad wo, false)
  | .kadd k a =>
    let (amask, aresult) := a.toSingleWidthMaskNondepTerm wo
    if aresult then
      ((amask.succ.shiftl wo k).pred, true)
    else (.constBad wo, false)

/-#

## Notes on sign-extension implementation:


#### The classic branchless sign-extension trick:

```
  s = (mold + 1) >> 1          -- sign bit mask (MSB of the old width)
  v = x & mold                 -- isolate the value bits
  y = ((v ^ s) - s) & mnew     -- sign-extend and mask to new width
```

### Why it works:

s is the sign-bit position of the old width. Since mold = 2^k - 1, we get s = 2^(k-1).

The XOR-subtract trick (v ^ s) - s is a well-known identity:
- If the sign bit is `0`: `v ^ s` sets bit k-1, then `- s` clears it again. Result = v unchanged.
- If the sign bit is `1`: `v ^ s` clears bit k-1, then `- s` causes a borrow that propagates through all higher bits, filling them with 1s. Result = sign-extended v.

Positive case, v = 0b0101 (+5):

```
s       = 0b1000
v ^ s   = 0b1101
- s     = 0b0101
& mnew  = 0b0101       ✓  (5 unchanged)
```

Alternative for s:
if you don't like (mold + 1) >> 1,
you can also write s = mold ^ (mold >> 1),
which extracts just the top bit of a unary mask
-/

/--
Compute MSB of `x` at width mask `mask`.
-/
def Nondep.Term.toSingleWidthNondepMsb (x : Nondep.Term) (wx : Nondep.WidthExpr) (wo : Nondep.WidthExpr) :
    Nondep.Term × Bool :=
  let (mask, maskResult) := wx.toSingleWidthMaskNondepTerm wo
  if maskResult then
    let maskSucc := mask.succ -- mask + 1 = 100000
    let msbIx := maskSucc.shiftr wo 1 -- (mask + 1) >>> 1 = 010000
    let msb := x.band wo msbIx
    (msb, true)
  else (.constBad wo, false)


/--
TODO: refactor into `SingleWidth → Nondep.Term × Bool`, since it's better typed.
Then this function will be `Nondep.Term → SingleWidth → Nondep.Term × Bool`, and the preconditions can be generated separately.
For the `Nondep.Term → SingleWidth` translation, change type to `Nondep.Term → SingleWidth × Bool`.
-/
def Nondep.Term.toSingleWidthNondepTermGo (maxWcard : Nat) (t : Nondep.Term) (wo : Nondep.WidthExpr) : Nondep.Term × Bool :=
  match t with
  | .var v w =>
    -- bitvector variables become bitvectors,
    -- masked with the width value.
    let x := Nondep.Term.var (v + maxWcard) wo
    let (wmask, wresult) := w.toSingleWidthMaskNondepTerm wo
    if wresult then
      (.band wo x wmask, true) -- mask the variable to the universe width.
    else (.constBad wo, false)
  | .ofNat w n =>
      let (wmask, wresult) := w.toSingleWidthMaskNondepTerm wo
      let bv := Nondep.Term.ofNat wo n
      if wresult then
        (.band wo bv wmask, true) -- mask the constant to the universe width.
      else (.constBad wo, false)
  | .add w a b =>
    let (a', aresult) := a.toSingleWidthNondepTermGo maxWcard wo
    let (b', bresult) := b.toSingleWidthNondepTermGo maxWcard wo
    let (wmask, wresult) := w.toSingleWidthMaskNondepTerm wo
    if aresult && bresult && wresult then
      (.band wo (.add wo a' b') wmask, true) -- mask the result to the universe width.
    else (.constBad wo, false)
  | .band _w a b =>
    let (a', aresult) := a.toSingleWidthNondepTermGo maxWcard wo
    let (b', bresult) := b.toSingleWidthNondepTermGo maxWcard wo
    if aresult && bresult then
      -- AND cannot overflow, so we don't need to mask the result to the universe width.
      ((.band wo a' b'), true)
    else (.constZero wo, false)
  | .bor _w a b =>
    let (a', aresult) := a.toSingleWidthNondepTermGo maxWcard wo
    let (b', bresult) := b.toSingleWidthNondepTermGo maxWcard wo
    if aresult && bresult then
      -- OR cannot overflow, so we don't need to mask the result to the universe width.
      ((.bor wo a' b'), true)
    else (.constZero wo, false)
  | .bxor _w a b =>
    let (a', aresult) := a.toSingleWidthNondepTermGo maxWcard wo
    let (b', bresult) := b.toSingleWidthNondepTermGo maxWcard wo
    if aresult && bresult then
      -- XOR cannot overflow, so we don't need to mask the result to the universe width.
      ((.bxor wo a' b'), true)
    else (.constZero wo, false)
  | .bnot _w a =>
    let (a', aresult) := a.toSingleWidthNondepTermGo maxWcard wo
    if aresult then
      -- NOT cannot overflow, so we don't need to mask the result to the universe width.
      ((.bnot wo a'), true)
    else (.constZero wo, false)
  | .mul w a b =>
    let (a', aresult) := a.toSingleWidthNondepTermGo maxWcard wo
    let (b', bresult) := b.toSingleWidthNondepTermGo maxWcard wo
    let (wmask, wresult) := w.toSingleWidthMaskNondepTerm wo
    if aresult && bresult && wresult then
      (.band wo (.mul wo a' b') wmask, true) -- mask the result to the universe width.
    else (.constBad wo, false)
  | .shiftl w x k =>
    let (x', xresult) := x.toSingleWidthNondepTermGo maxWcard wo
    let (wmask, wresult) := w.toSingleWidthMaskNondepTerm wo
    if xresult && wresult then
      (.band wo (.shiftl wo x' k) wmask, true) -- mask the result to the universe width.
    else (.constBad wo, false)
  | .boolConst _ => (t, true)
  | .zext x wnew | .setWidth x wnew =>
    let (x', xresult) := x.toSingleWidthNondepTermGo maxWcard wo
    let (wmask, wresult) := wnew.toSingleWidthMaskNondepTerm wo
    if xresult && wresult then
      (.band wo x' wmask, true)
    else (.constBad wo, false)
  | .sext x wnew =>
      let w := x.width
      let (wmaskNew, wnewResult) := wnew.toSingleWidthMaskNondepTerm wo
      let (x', xresult) := x.toSingleWidthNondepTermGo maxWcard wo
      let (msb, msbResult) := x'.toSingleWidthNondepMsb w wo
      -- x' ^ msb - msb
      let y := (Nondep.Term.sub wo (Nondep.Term.bxor wo x' msb) msb)
      let ymasked := Nondep.Term.band wo y wmaskNew
      if xresult && msbResult && wnewResult then
        (ymasked, true)
      else (.constBad wo, false)
  | .and p q =>
    let (p', presult) := p.toSingleWidthNondepTermGo maxWcard wo
    let (q', qresult) := q.toSingleWidthNondepTermGo maxWcard wo
    if presult && qresult then
      (.and p' q', true)
    else (.constBad wo, false)
  | .or p q =>
    let (p', presult) := p.toSingleWidthNondepTermGo maxWcard wo
    let (q', qresult) := q.toSingleWidthNondepTermGo maxWcard wo
    if presult && qresult then
      (.or p' q', true)
    else (.constBad wo, false)
  | .pTrue => (.pTrue, true)
  | .pFalse => (.pFalse, true)
  | .binRel k w x y =>
    let (x', xresult) := x.toSingleWidthNondepTermGo maxWcard wo
    let (y', yresult) := y.toSingleWidthNondepTermGo maxWcard wo
    let (wmask, wresult) := w.toSingleWidthMaskNondepTerm wo
    if xresult && yresult && wresult then
      let xMasked := .band wo x' wmask
      let yMasked := .band wo y' wmask
      match k with
      | .eq => (.binRel .eq wo xMasked yMasked, true)
      | .ne => (.binRel .ne wo xMasked yMasked, true)
      | .ult => (.binRel .ult wo xMasked yMasked, true)
      | .ule => (.binRel .ule wo xMasked yMasked, true)
      | _ => (.constBad wo, false)
    else (.constBad wo, false)
  | .binWidthRel k wa wb =>
    let (wa', waresult) := wa.toSingleWidthMaskNondepTerm wo
    let (wb', wbresult) := wb.toSingleWidthMaskNondepTerm wo
    if waresult && wbresult then
      match k with
      | .eq => (.binRel .eq wo wa' wb', true)
      | .le => (.binRel .ule wo wa' wb', true)
    else (.constBad wo, false)
  | .shiftr w x k =>
    let (x', xresult) := x.toSingleWidthNondepTermGo maxWcard wo
    let (wmask, wresult) := w.toSingleWidthMaskNondepTerm wo
    if xresult && wresult then
      (.band wo (.shiftr wo x' k) wmask, true) -- mask the result to the universe width.
    else (.constBad wo, false)
  | .udiv w a b =>
    let (a', aresult) := a.toSingleWidthNondepTermGo maxWcard wo
    let (b', bresult) := b.toSingleWidthNondepTermGo maxWcard wo
    let (wmask, wresult) := w.toSingleWidthMaskNondepTerm wo
    if aresult && bresult && wresult then
      (.band wo (.udiv wo a' b') wmask, true)
    else (.constBad wo, false)
  | .urem w a b =>
    let (a', aresult) := a.toSingleWidthNondepTermGo maxWcard wo
    let (b', bresult) := b.toSingleWidthNondepTermGo maxWcard wo
    let (wmask, wresult) := w.toSingleWidthMaskNondepTerm wo
    if aresult && bresult && wresult then
      (.band wo (.urem wo a' b') wmask, true)
    else (.constBad wo, false)
  | .vlshr w a b =>
    let (a', aresult) := a.toSingleWidthNondepTermGo maxWcard wo
    let (b', bresult) := b.toSingleWidthNondepTermGo maxWcard wo
    let (wmask, wresult) := w.toSingleWidthMaskNondepTerm wo
    if aresult && bresult && wresult then
      (.band wo (.vlshr wo a' b') wmask, true)
    else (.constBad wo, false)
  | .vashr _w _a _b =>
    -- Arithmetic right shift in single-width encoding is complex (needs sign extension).
    -- Return unsupported for now.
    (.constBad wo, false)
  | .vshl w a b =>
    let (a', aresult) := a.toSingleWidthNondepTermGo maxWcard wo
    let (b', bresult) := b.toSingleWidthNondepTermGo maxWcard wo
    let (wmask, wresult) := w.toSingleWidthMaskNondepTerm wo
    if aresult && bresult && wresult then
      (.band wo (.vshl wo a' b') wmask, true)
    else (.constZero wo, false)
  | pvar _ | bvOfBool _ | boolVar _ | boolBinRel .. =>
    (.constZero wo, false)

  -- | _ => (.constBad wo, false)

/--
Given a term, convert it to a single-width term by converting all width expressions to their corresponding single-width terms,
-/
def Nondep.Term.toSingleWidthNondepTerm (t : Nondep.Term) (wo : Nondep.WidthExpr): Nondep.Term × Bool :=
  let preconds := Term.toSingleWidthNondepTerm.mkAllWidthPreconds wo t.maxwcard
  let (rhs, rhsResult) : Nondep.Term × Bool := t.toSingleWidthNondepTermGo t.maxwcard wo
  let (implies, impliesResult) := Term.pimplies preconds rhs
  if rhsResult && impliesResult then
    (implies, true)
  else (implies, false)

end ToSingleWidth

end MultiWidth
