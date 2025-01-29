/-
Released under Apache 2.0 license as described in the file LICENSE.
This file reflects the semantics of bitstreams, terms, predicates, and FSMs
into lean bitvectors.

We use `bv_circuit_nnf` to convert the expression into negation normal form.

Authors: Siddharth Bhat
-/
import Mathlib.Data.Bool.Basic
import Mathlib.Data.Fin.Basic
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Finset.Defs
import Mathlib.Data.Multiset.FinsetOps
import SSA.Experimental.Bits.Fast.BitStream
import SSA.Experimental.Bits.Fast.Defs
import SSA.Experimental.Bits.Fast.FiniteStateMachine
import SSA.Experimental.Bits.Fast.Attr
import SSA.Experimental.Bits.Fast.Decide
import Lean.Meta.ForEachExpr
import Lean.Meta.Tactic.Simp.BuiltinSimprocs.BitVec

import Lean

/-
TODO:
- [?] BitVec.ofInt
    + This is sadly more subtle than I realized.
    + In the infinite width model, we have something like
        `∀ w, (negOnes w).getLsb 20 = true`
      However, this is patently untrue in lean, since we can instantiate `w = 0`.
    + So, it's not clear to me that this makes sense in the lean model of things?
      However, there is the funnny complication that we don't actually support getLsb,
      or right shift to access that bit before we reach that bitwidth, so the abstraction
      may still be legal, for reasons that I don't clearly understand now :P
    + Very interesting subtleties!
    + I currently add support for BitVec.ofInt, with the knowledge that I can remove it
      if I'm unable to prove soundness.
- [x] leftShift
- [x] Break down numeral multiplication into left shift:
       10 * z
       = z <<< 1 + 5 * z
       = z <<< 1 + (z + 4 * z)
       = z <<< 1 + (z + z <<< 2).
       Needs O(log |N|) terms.
    + Wrote the theorems needed to perform the simplification.
    + Need to write the `simproc`.

- [x] Check if the constants we support work for (a) hackers delight and (b) gsubhxor_proof
    + Added support for hacker's delight numerals. Checked by running files
        SSA/Projects/InstCombine/HackersDelight/ch2_1DeMorgan.lean
	      SSA/Projects/InstCombine/HackersDelight/ch2_2AdditionAndLogicalOps.lean
    + gsubhxor: We need support for `signExtend`, which we don't have yet :)
      I can add this.
- [ ] `signExtend`  support.
- [WONTFIX] `zeroExtend support: I don't think this is possible either, since zero extension
  is not a property that correctly extends across bitwidths. That is, it's not an
  'arithmetical' property so I don't know how to do it right!
- [ ] Write custom fast decision procedure for constant widths.
-/

/--
Denote a bitstream into the underlying bitvector, by using toBitVec
def BitStream.denote (s : BitStream) (w : Nat) : BitVec w := s.toBitVec w
-/

@[simp] theorem BitStream.toBitVec_zero : BitStream.toBitVec w BitStream.zero = 0#w := by
  induction w
  case zero => simp [toBitVec, BitStream.zero]
  case succ n ih =>
    simp [toBitVec, toBitVec, BitStream.zero]
    have : 0#(n + 1) = BitVec.cons false 0#n := by simp
    rw [this, ih]

@[simp] theorem BitStream.toBitVec_negOne : BitStream.toBitVec w BitStream.negOne = BitVec.allOnes w := by
  induction w
  case zero => simp [toBitVec, BitStream.zero]
  case succ n ih =>
    simp [toBitVec, toBitVec, BitStream.zero]
    rw [ih]
    apply BitVec.eq_of_getLsbD_eq
    simp only [BitVec.getLsbD_cons, BitVec.getLsbD_allOnes, Bool.if_true_left]
    intros i hi
    simp only [hi, decide_true, Bool.or_eq_true, decide_eq_true_eq]
    omega

@[simp] theorem BitStream.toBitVec_one : BitStream.toBitVec w BitStream.one = 1#w := by
  induction w
  case zero => simp [toBitVec, BitStream.zero]
  case succ n ih =>
    simp [toBitVec, toBitVec, BitStream.one]
    rw [ih]
    apply BitVec.eq_of_getLsbD_eq
    intros i hi
    simp [BitVec.getLsbD_cons]
    by_cases hi' : i = n
    · simp [hi']
      by_cases hn : n = 0 <;> simp [hn]
    · simp [hi']
      omega

open Lean in
def mkBoolLit (b : Bool) : Expr :=
  match b with
  | true => mkConst ``true
  | false => mkConst ``false

open Lean in
def Term.quote (t : _root_.Term) : Expr :=
  match t with
  | ofNat n => mkApp (mkConst ``Term.ofNat) (mkNatLit n)
  | var n => mkApp (mkConst ``Term.var) (mkNatLit n)
  | zero => mkConst ``Term.zero
  | one => mkConst ``Term.one
  | negOne => mkConst ``Term.negOne
-- | decr t => mkApp (mkConst ``Term.decr) (t.quote)
  -- | incr t => mkApp (mkConst ``Term.incr) (t.quote)
  | neg t => mkApp (mkConst ``Term.neg) (t.quote)
  | not t => mkApp (mkConst ``Term.not) (t.quote)
  | ls b t => mkApp2 (mkConst ``Term.ls) (mkBoolLit b) (t.quote)
  | sub t₁ t₂ => mkApp2 (mkConst ``Term.sub) (t₁.quote) (t₂.quote)
  | add t₁ t₂ => mkApp2 (mkConst ``Term.add) (t₁.quote) (t₂.quote)
  | xor t₁ t₂ => mkApp2 (mkConst ``Term.xor) (t₁.quote) (t₂.quote)
  | or t₁ t₂ => mkApp2 (mkConst ``Term.or) (t₁.quote) (t₂.quote)
  | and t₁ t₂ => mkApp2 (mkConst ``Term.and) (t₁.quote) (t₂.quote)
  | shiftL t₁ n => mkApp2 (mkConst ``Term.shiftL) (t₁.quote) (mkNatLit n)

open Lean in
def Predicate.quote (p : _root_.Predicate) : Expr :=
  match p with
  | widthEq n => mkApp (mkConst ``Predicate.widthEq) (mkNatLit n)
  | widthNeq n => mkApp (mkConst ``Predicate.widthNeq) (mkNatLit n)
  | widthLt n => mkApp (mkConst ``Predicate.widthLt) (mkNatLit n)
  | widthLe n => mkApp (mkConst ``Predicate.widthLe) (mkNatLit n)
  | widthGt n => mkApp (mkConst ``Predicate.widthGt) (mkNatLit n)
  | widthGe n => mkApp (mkConst ``Predicate.widthGe) (mkNatLit n)
  | eq a b => mkApp2 (mkConst ``Predicate.eq) (_root_.Term.quote a) (_root_.Term.quote b)
  | neq a b => mkApp2 (mkConst ``Predicate.neq) (_root_.Term.quote a) (_root_.Term.quote b)
  | ult a b => mkApp2 (mkConst ``Predicate.ult) (_root_.Term.quote a) (_root_.Term.quote b)
  | ule a b => mkApp2 (mkConst ``Predicate.ule) (_root_.Term.quote a) (_root_.Term.quote b)
  | slt a b => mkApp2 (mkConst ``Predicate.slt) (_root_.Term.quote a) (_root_.Term.quote b)
  | sle a b => mkApp2 (mkConst ``Predicate.sle) (_root_.Term.quote a) (_root_.Term.quote b)
  | land p q => mkApp2 (mkConst ``Predicate.land) (Predicate.quote p) (Predicate.quote q)
  | lor p q => mkApp2 (mkConst ``Predicate.lor) (Predicate.quote p) (Predicate.quote q)

/-- toBitVec a Term into its underlying bitvector -/
def Term.denote (w : Nat) (t : Term) (vars : List (BitVec w)) : BitVec w :=
  match t with
  | ofNat n => BitVec.ofNat w n
  | var n => vars.getD n default
  | zero => 0#w
  | negOne => -1#w
  | one  => 1#w
  | and a b => (a.denote w vars) &&& (b.denote w vars)
  | or a b => (a.denote w vars) ||| (b.denote w vars)
  | xor a b => (a.denote w vars) ^^^ (b.denote w vars)
  | not a => ~~~ (a.denote w vars)
  | add a b => (a.denote w vars) + (b.denote w vars)
  | sub a b => (a.denote w vars) - (b.denote w vars)
  | neg a => - (a.denote w vars)
  -- | incr a => (a.denote w vars) + 1#w
  -- | decr a => (a.denote w vars) - 1#w
  | ls bit a => (a.denote w vars).shiftConcat bit
  | shiftL a n => (a.denote w vars) <<< n

@[simp]
theorem BitStream.toBitVec_ofNat : BitStream.toBitVec w (BitStream.ofNat n) = BitVec.ofNat w n := by
  simp [toBitVec, ofNat]
  apply BitVec.eq_of_getLsbD_eq
  intros i
  simp [BitVec.getLsbD_ofNat]

@[simp]
theorem BitStream.toBitVec_and (a b : BitStream) :
    (a &&& b).toBitVec w = a.toBitVec w &&& b.toBitVec w := by
  apply BitVec.eq_of_getLsbD_eq
  intros i hi
  simp [hi]

@[simp]
theorem BitStream.toBitVec_or (a b : BitStream) :
    (a ||| b).toBitVec w = a.toBitVec w ||| b.toBitVec w := by
  apply BitVec.eq_of_getLsbD_eq
  intros i hi
  simp [hi]

@[simp]
theorem BitStream.toBitVec_xor (a b : BitStream) :
    (a ^^^ b).toBitVec w = a.toBitVec w ^^^ b.toBitVec w := by
  apply BitVec.eq_of_getLsbD_eq
  intros i
  intros hi
  simp [hi]

@[simp]
theorem BitStream.toBitVec_not (a : BitStream) :
    (~~~ a).toBitVec w = ~~~ (a.toBitVec w) := by
  apply BitVec.eq_of_getLsbD_eq
  intros i hi
  simp [hi]

theorem BitVec.add_getLsbD_zero {x y : BitVec w} (hw : 0 < w) : (x + y).getLsbD 0 =
    ((x.getLsbD 0 ^^ y.getLsbD 0)) := by
  simp [hw, getLsbD_add hw]

theorem BitVec.add_getLsbD_succ (x y : BitVec w) (hw : i + 1 < w) : (x + y).getLsbD (i + 1) =
    (x.getLsbD (i + 1) ^^ (y.getLsbD (i + 1)) ^^ carry (i + 1) x y false) := by
  simp [hw, getLsbD_add hw]

/-- TODO: simplify this proof, something too complex is going on here. -/
@[simp] theorem BitStream.toBitVec_add' (a b : BitStream) (w i : Nat) (hi : i < w) :
    ((a + b).toBitVec w).getLsbD i = ((a.toBitVec w) + (b.toBitVec w)).getLsbD i ∧
    (a.addAux b i).2 = (BitVec.carry (i + 1) (a.toBitVec w) (b.toBitVec w) false) := by
  simp [hi]
  rw [BitStream.add_eq_addAux]
  induction i
  case zero =>
    simp
    rw [BitVec.add_getLsbD_zero hi]
    simp [hi]
    simp [BitVec.carry_succ, hi]
  case succ i ih =>
    simp
    rw [BitVec.add_getLsbD_succ _ _ hi]
    have : i < w := by omega
    specialize ih this
    obtain ⟨ih₁, ih₂⟩ := ih
    rw [ih₂]
    simp [hi]
    rw [BitVec.carry_succ (i + 1)]
    simp [hi]

@[simp] theorem BitStream.toBitVec_add (a b : BitStream) :
    (a + b).toBitVec w = (a.toBitVec w) + (b.toBitVec w) := by
  apply BitVec.eq_of_getLsbD_eq
  intros i hi
  obtain ⟨h₁, h₂⟩ := BitStream.toBitVec_add' a b w i hi
  exact h₁

@[simp]
theorem BitStream.toBitVec_neg (a : BitStream) :
    (- a).toBitVec w = - (a.toBitVec w) := by
  simp [neg_eq_not_add_one, BitStream.toBitVec_add, BitVec.neg_eq_not_add]

@[simp]
theorem BitStream.toBitVec_sub (a b : BitStream) :
    (a - b).toBitVec w = (a.toBitVec w) - (b.toBitVec w) := by
  simp [BitVec.sub_eq_add_neg, sub_eq_add_neg]

@[simp] theorem BitStream.subAux_eq_BitVec_carry (a b : BitStream) (w i : Nat) (hi : i < w) :
    (a.subAux b i).2 = !(BitVec.carry (i + 1) (a.toBitVec w) ((~~~b).toBitVec w) true) := by
  induction i
  case zero =>
    simp
    simp [BitVec.carry_succ, BitStream.subAux, hi, Bool.atLeastTwo]
    rcases a 0 <;> rcases b 0 <;> rfl
  case succ i ih =>
    have : i < w := by omega
    specialize ih this
    rw [BitVec.carry_succ (i + 1)]
    simp [hi]
    rw [subAux, ih]
    simp
    rcases a (i + 1) <;> rcases b (i + 1) <;> simp

@[simp]
theorem BitStream.toBitVec_shiftL (a : BitStream) (k : Nat) :
    (a.shiftLeft k).toBitVec w = (a.toBitVec w).shiftLeft k := by
  apply BitVec.eq_of_getLsbD_eq
  intros i hi
  simp [hi]
  by_cases hk : i < k
  · simp [hk]
  · simp [hk]; omega

@[simp]
theorem BitStream.toBitVec_concat_zero (a : BitStream) :
    (a.concat b).toBitVec 0 = 0#0 := by simp [toBitVec]

@[simp]
theorem BitStream.toBitVec_concat_succ (a : BitStream) :
    (a.concat b).toBitVec (w + 1) = (a.toBitVec w).concat b := by
  apply BitVec.eq_of_getLsbD_eq
  simp
  intros i hi
  simp [hi]
  rcases i with rfl | i
  · simp
  · simp; omega

@[simp]
theorem BitStream.toBitVec_concat(a : BitStream) :
    (a.concat b).toBitVec w =
      match w with
      | 0 => 0#0
      | w + 1 => (a.toBitVec w).concat b  := by
  rcases w with rfl | w <;> simp

/--
Evaluating the term and then coercing the term to a bitvector is equal to denoting the term directly.
-/
@[simp] theorem Term.eval_eq_denote (t : Term) (w : Nat) (vars : List (BitVec w)) :
    (t.eval (vars.map BitStream.ofBitVec)).toBitVec w = t.denote w vars := by
  induction t generalizing w vars
  case var x =>
    simp [eval, denote]
    cases x? : vars[x]?
    case none => simp [default, denote]
    case some x => simp [BitVec.signExtend_eq_setWidth_of_lt]
  case zero => simp [eval, denote]
  case negOne => simp [eval, denote]; rw [← BitVec.negOne_eq_allOnes]
  case one => simp [eval, denote]
  case ofNat n => simp [eval, denote]
  case and a b ha hb  => simp [eval, denote, ha, hb]
  case or a b ha hb => simp [eval, denote, ha, hb]
  case xor a b ha hb => simp [eval, denote, ha, hb]
  case not a ha => simp [eval, denote, ha]
  case ls b a ha  =>
    simp [eval, denote]
    apply BitVec.eq_of_getLsbD_eq
    intros i hi
    specialize ha w vars
    rcases w with rfl | w
    · simp
    · simp
      rw [BitVec.getLsbD_shiftConcat]
      rw [BitVec.getLsbD_concat]
      simp [hi]
      rcases i with rfl | i
      · simp
      · simp only [AddLeftCancelMonoid.add_eq_zero, one_ne_zero, and_false, ↓reduceIte,
        add_tsub_cancel_right, show i < w by omega, decide_true, Bool.true_and]
        rw [← ha]
        simp; omega
  case add a b ha hb => simp [eval, denote, ha, hb]
  case sub a b ha hb => simp [eval, denote, ha, hb]
  case neg a ha => simp [eval, denote, ha]
  case shiftL a ha => simp [eval, denote, ha]

/-
This says that calling 'eval' at an index equals calling 'denote' and grabbing the bitstream
 at that index, as long as the value is inbounds, and if not, it's going to be 'false'
 -/
theorem Term.eval_eq_denote_apply (t : Term) {w : Nat} {vars : List (BitVec w)}
    {i : Nat} (hi : i < w) :
    (t.eval (vars.map BitStream.ofBitVec)) i = (t.denote w vars).getLsbD i := by
  have := t.eval_eq_denote w vars
  have :
    (BitStream.toBitVec w (t.eval (List.map BitStream.ofBitVec vars))).getLsbD i =
    (denote w t vars).getLsbD i := by simp [this]
  rw [BitStream.getLsbD_toBitVec] at this
  simp only [show i < w by omega, decide_true, Bool.true_and] at this
  simp [this]

/-
This says that calling 'eval' at an index equals calling 'denote' and grabbing the bitstream
 at that index, as long as the value is inbounds, and if not, it's going to be 'false'
 -/
theorem Term.denote_eq_eval_land_lt (t : Term) {w : Nat} {vars : List (BitVec w)}
    {i : Nat} :
    (t.denote w vars).getLsbD i = ((t.eval (vars.map BitStream.ofBitVec)) i && (decide (i < w))) := by
  have := t.eval_eq_denote w vars
  have :
    (BitStream.toBitVec w (t.eval (List.map BitStream.ofBitVec vars))).getLsbD i =
    (denote w t vars).getLsbD i := by simp [this]
  rw [BitStream.getLsbD_toBitVec] at this
  by_cases hi : i < w
  · simp [hi] at this
    simp [this, hi]
  · simpa [hi] using this

def Predicate.denote (p : Predicate) (w : Nat) (vars : List (BitVec w)) : Prop :=
  match p with
  | .widthGe k => k ≤ w -- w ≥ k
  | .widthGt k => k < w -- w > k
  | .widthLe k => w ≤ k
  | .widthLt k => w < k
  | .widthNeq k => w ≠ k
  | .widthEq k => w = k
  | .eq t₁ t₂ => t₁.denote w vars = t₂.denote w vars
  | .neq t₁ t₂ => t₁.denote w vars ≠ t₂.denote w vars
  | .land  p q => p.denote w vars ∧ q.denote w vars
  | .lor  p q => p.denote w vars ∨ q.denote w vars
  | .sle  t₁ t₂ => ((t₁.denote w vars).sle (t₂.denote w vars)) = true
  | .slt  t₁ t₂ => ((t₁.denote w vars).slt (t₂.denote w vars)) = true
  | .ule  t₁ t₂ => ((t₁.denote w vars) ≤ (t₂.denote w vars))
  | .ult  t₁ t₂ => (t₁.denote w vars) < (t₂.denote w vars)

/--
The cost model of the predicate, which is based on the cardinality of the state space,
and the size of the circuits.
-/
def Predicate.cost (p : Predicate) : Nat :=
  let fsm := predicateEvalEqFSM p
  fsm.circuitSize


/-
if 'evalEq' evaluates to 'false', then indeed the denotations of the terms are equal.
-/
theorem Predicate.evalEq_denote_false_iff {w : Nat} (a b : Term) (vars : List (BitVec w)) :
    evalEq (a.eval (List.map BitStream.ofBitVec vars)) (b.eval (List.map BitStream.ofBitVec vars)) w = false ↔
    Term.denote w a vars = Term.denote w b vars := by
  simp [evalEq]
  constructor
  · intros h
    /- Dear god, this proof is ugly. -/
    simp only [BitStream.scanOr_false_iff, BitStream.xor_eq, bne_eq_false_iff_eq] at h
    apply BitVec.eq_of_getLsbD_eq
    intros i hi
    specialize h (i + 1) (by omega)
    simp at h
    rw [Term.eval_eq_denote_apply a hi, Term.eval_eq_denote_apply b  hi] at h
    exact h
  · intros h
    rw [BitStream.scanOr_false_iff]
    intros i hi
    rcases i with rfl | i
    · simp
    · simp
      rw [Term.eval_eq_denote_apply a (by omega), Term.eval_eq_denote_apply b (by omega), h]

/-- evalEq is true iff evalNeq is false -/
theorem Predicate.evalEq_iff_not_evalNeq (a b : BitStream) :
    ∀ (w : Nat), evalEq a b w ↔ ¬ (evalNeq a b w) := by
  intros w
  rcases w with rfl | w
  · simp [evalEq, evalNeq]
  · simp [evalEq, evalNeq]
    by_cases hab : a w = b w
    · simp [hab]
      by_cases heq : (BitStream.concat false (a ^^^ b)).scanOr w
      · simp [heq]
        rw [BitStream.scanAnd_false_iff]
        rw [BitStream.scanOr_true_iff] at heq
        obtain ⟨i, hi, hi'⟩ := heq
        exists i
        simp [hi]
        rcases i with rfl | i
        · simp at hi'
        · simpa using hi'
      · simp [heq]
        rw [BitStream.scanAnd_true_iff]
        simp at heq
        intros i hi
        rw [BitStream.scanOr_false_iff] at heq
        specialize (heq i hi)
        rcases i with rfl | i
        · simp
        · simpa using heq
    · simp [hab]




/-- 'evalNeq' correctly witnesses when terms are disequal -/
theorem Predicate.evalNeq_denote {w : Nat} (a b : Term) (vars : List (BitVec w)) :
    evalNeq (a.eval (List.map BitStream.ofBitVec vars)) (b.eval (List.map BitStream.ofBitVec vars)) w = false ↔
    Term.denote w a vars ≠ Term.denote w b vars := by
  constructor
  · intros h
    apply Predicate.evalEq_denote_false_iff .. |>.not.mp
    simp only [Bool.not_eq_false]
    have := Predicate.evalEq_iff_not_evalNeq
      (a.eval (List.map BitStream.ofBitVec vars))
      (b.eval (List.map BitStream.ofBitVec vars))
    apply this .. |>.mpr
    simp [h]
  · intros h
    have this' := Predicate.evalEq_denote_false_iff .. |>.not.mpr h
    simp at this'
    have := Predicate.evalEq_iff_not_evalNeq
      (a.eval (List.map BitStream.ofBitVec vars))
      (b.eval (List.map BitStream.ofBitVec vars)) w |>.mp this'
    simpa using this

theorem Predicate.evalEq_denote_true_iff {w : Nat} (a b : Term) (vars : List (BitVec w)) :
    evalEq (a.eval (List.map BitStream.ofBitVec vars)) (b.eval (List.map BitStream.ofBitVec vars)) w = true ↔
    Term.denote w a vars ≠ Term.denote w b vars := by
  rw [Predicate.evalEq_iff_not_evalNeq]
  simp [evalNeq_denote]


private theorem BitVec.lt_eq_decide_ult {x y : BitVec w} : (x < y) = decide (x.ult y) := by
  simp [BitVec.lt_def, BitVec.ult_toNat]

private theorem BitVec.lt_iff_ult {x y : BitVec w} : (x < y) ↔ (x.ult y) := by
  simp [BitVec.lt_def, BitVec.ult_toNat]

theorem Predicate.evalUlt_denote_false_iff {w : Nat} (a b : Term) (vars : List (BitVec w)) :
    evalUlt (a.eval (List.map BitStream.ofBitVec vars)) (b.eval (List.map BitStream.ofBitVec vars)) w = false ↔
    (Term.denote w a vars < Term.denote w b vars) := by
  simp [evalUlt, Term.eval_eq_denote_apply, BitVec.lt_eq_decide_ult, BitVec.ult_eq_not_carry]
  rcases w with rfl | w
  · simp [evalUlt, BitVec.of_length_zero]
  · simp [evalUlt, BitVec.of_length_zero, BitVec.lt_eq_decide_ult, BitVec.ult_eq_not_carry]
    simp [BitStream.borrow, BitStream.subAux_eq_BitVec_carry (w := w + 1)]

theorem Predicate.evalUlt_denote_true_iff {w : Nat} (a b : Term) (vars : List (BitVec w)) :
    evalUlt (a.eval (List.map BitStream.ofBitVec vars)) (b.eval (List.map BitStream.ofBitVec vars)) w = true ↔
      (Term.denote w b vars) ≤ (Term.denote w a vars) := by
  obtain ⟨h₁, h₂⟩ := evalUlt_denote_false_iff a b vars
  constructor
  · intros h
    by_contra h'
    simp at h'
    specialize (h₂ h')
    simp [h₂] at h
  · intros h
    by_contra h'
    simp at h'
    specialize (h₁ h')
    bv_omega

private theorem evalMsbEq_denote_false_iff {w : Nat} (a b : Term) (vars : List (BitVec w)) :
    Predicate.evalMsbEq (a.eval (List.map BitStream.ofBitVec vars)) (b.eval (List.map BitStream.ofBitVec vars)) w = false ↔
   ((Term.denote w a vars).msb = (Term.denote w b vars).msb) := by
  simp [Predicate.evalMsbEq]
  rcases w with rfl | w
  · simp [BitVec.of_length_zero]
  · simp [BitVec.msb_eq_getLsbD_last, Term.eval_eq_denote_apply]

private theorem evalMsbEq_denote_true_iff {w : Nat} (a b : Term) (vars : List (BitVec w)) :
    Predicate.evalMsbEq (a.eval (List.map BitStream.ofBitVec vars)) (b.eval (List.map BitStream.ofBitVec vars)) w = true ↔
   ((Term.denote w a vars).msb ≠ (Term.denote w b vars).msb) := by
  simp [Predicate.evalMsbEq]
  rcases w with rfl | w
  · simp [BitVec.of_length_zero]
  · simp [BitVec.msb_eq_getLsbD_last, Term.eval_eq_denote_apply]

theorem eq_true_iff_of_eq_false_iff (b : Bool) (rhs : Prop) (h : (b = false) ↔ rhs) :
    (b = true) ↔ ¬ rhs := by
constructor
· intros h'
  apply h.not.mp
  simp [h']
· intros h'
  by_contra hcontra
  simp at hcontra
  have := h.mp hcontra
  exact h' this

/-- TODO: Minimize this proof by a metric fuckton. -/
private theorem Predicate.evalSlt_denote_false_iff {w : Nat} (a b : Term) (vars : List (BitVec w)) :
    evalSlt (a.eval (List.map BitStream.ofBitVec vars)) (b.eval (List.map BitStream.ofBitVec vars)) w = false ↔
    (Term.denote w a vars <ₛ Term.denote w b vars) := by
  simp [evalSlt, BitStream.not_eq, BitStream.xor_eq, Bool.not_bne', beq_eq_false_iff_ne, ne_eq]
  have hult_iff := Predicate.evalUlt_denote_false_iff a b vars
  by_cases hUlt : evalUlt (a.eval (List.map BitStream.ofBitVec vars)) (b.eval (List.map BitStream.ofBitVec vars)) w
  · rw [hUlt]
    have hUlt' := evalUlt_denote_true_iff .. |>.mp hUlt
    simp
    by_cases hMsbEq : evalMsbEq (a.eval (List.map BitStream.ofBitVec vars)) (b.eval (List.map BitStream.ofBitVec vars)) w
    · rw [hMsbEq]
      have hMsbEq' := evalMsbEq_denote_true_iff .. |>.mp hMsbEq
      simp
      rw [BitVec.slt_eq_ult]
      -- TODO: how to deal with booleans properly? This is making my life pretty miserable at the moment.
      have : ((Term.denote w a vars).msb != (Term.denote w b vars).msb) = true := by
        simp [hMsbEq']
      simp [this]
      rw [BitVec.ult]
      rw [BitVec.le_def] at hUlt'
      simp; omega
    · simp at hMsbEq
      have hMsbEq' := evalMsbEq_denote_false_iff .. |>.mp hMsbEq
      simp [hMsbEq]
      rw [BitVec.le_def] at hUlt'
      rw [BitVec.slt_eq_ult]
      rw [BitVec.ult]
      simp [show ¬ (Term.denote w a vars).toNat < (Term.denote w b vars).toNat by omega]
      simp [hMsbEq']
  · simp at hUlt
    rw [hUlt]
    have hUlt' := evalUlt_denote_false_iff .. |>.mp hUlt
    simp
    by_cases h' : evalMsbEq (a.eval (List.map BitStream.ofBitVec vars)) (b.eval (List.map BitStream.ofBitVec vars)) w
    · simp [h']
      rw [BitVec.slt_eq_ult]
      rw [BitVec.ult]
      rw [BitVec.lt_def] at hUlt'
      simp [hUlt']
      simp [evalMsbEq_denote_true_iff .. |>.mp h']
    · simp at h'
      simp [h']
      rw [BitVec.slt_eq_ult]
      rw [BitVec.ult]
      rw [BitVec.lt_def] at hUlt'
      simp [hUlt']
      simp [evalMsbEq_denote_false_iff .. |>.mp h']

private theorem Predicate.evalSlt_denote_true_iff {w : Nat} (a b : Term) (vars : List (BitVec w)) :
    evalSlt (a.eval (List.map BitStream.ofBitVec vars)) (b.eval (List.map BitStream.ofBitVec vars)) w = true ↔
    ¬ (Term.denote w a vars <ₛ Term.denote w b vars) := by
  rw [eq_true_iff_of_eq_false_iff]
  simp [Predicate.evalSlt_denote_false_iff]

/-- TODO: ForLean -/
private theorem BitVec.ForLean.ule_iff_ult_or_eq (x y : BitVec w) : x ≤ y ↔ (x = y ∨ x < y) := by
  constructor <;> bv_omega

private theorem BitVec.sle_iff_slt_or_eq (x y : BitVec w) : x.sle y ↔ (decide (x = y) ∨ x.slt y) := by
  simp [BitVec.slt, BitVec.sle]
  constructor
  · intros h
    suffices x.toInt = y.toInt ∨ x.toInt < y.toInt by
      rcases this with h | h
      · left
        apply BitVec.eq_of_toInt_eq h
      · right
        omega
    omega
  · intros h
    rcases h with rfl | h  <;> omega

/--
The semantics of a predicate:
The predicate, when evaluated, at index `i` is false iff the denotation is true.
-/
theorem Predicate.eval_eq_denote (w : Nat) (p : Predicate) (vars : List (BitVec w)) :
    (p.eval (vars.map BitStream.ofBitVec) w = false) ↔ p.denote w vars := by
  induction p generalizing vars w
  case widthEq n => simp [eval, denote]
  case widthNeq n => simp [eval, denote]
  case widthLt n => simp [eval, denote]
  case widthLe n => simp [eval, denote]
  case widthGt n => simp [eval, denote]
  case widthGe n => simp [eval, denote]
  case eq a b => simp [eval, denote]; apply evalEq_denote_false_iff
  case neq a b => simp [eval, denote]; apply evalNeq_denote
  case ult a b => simp [eval, denote]; apply evalUlt_denote_false_iff
  case slt a b =>
    simp [eval, denote];
    by_cases h : Term.denote w a vars <ₛ Term.denote w b vars
    · rw [h]
      simp [Predicate.evalSlt_denote_false_iff, h]
    · simp at h
      rw [h]
      simp only [Bool.not_false]
      by_contra h'
      simp only [Bool.not_eq_true] at h'
      rw [Predicate.evalSlt_denote_false_iff] at h'
      simp only [h, Bool.false_eq_true] at h'
  case ule a b =>
    simp [eval, denote];
    simp only [evalLor, BitStream.and_eq]
    rw [BitVec.ForLean.ule_iff_ult_or_eq]
    by_cases heq : Term.denote w a vars = Term.denote w b vars
    · rw [heq]
      simp [evalEq_denote_false_iff a b vars |>.mpr heq]
    · simp [heq]
      by_cases hlt : Term.denote w a vars < Term.denote w b vars
      · simp [hlt]
        simp [evalUlt_denote_false_iff a b vars |>.mpr hlt]
      · simp [hlt]
        have := evalEq_denote_false_iff a b vars |>.not |>.mpr heq
        simp only [this, true_and]
        have := evalUlt_denote_false_iff a b vars |>.not |>.mpr hlt
        simp only [this]
  case sle a b =>
    simp [eval, denote]
    simp only [evalLor, BitStream.and_eq]
    have h := BitVec.sle_iff_slt_or_eq (Term.denote w a vars) (Term.denote w b vars) |>.eq
    rcases hSle : Term.denote w a vars ≤ₛ Term.denote w b vars
    · simp [hSle] at h ⊢
      obtain ⟨h₁, h₂⟩ := h
      simp [evalEq_denote_true_iff .. |>.mpr h₁]
      rw [evalSlt_denote_true_iff .. |>.mpr]
      simp [h₂]
    · simp [hSle] at h ⊢
      intros hEq
      simp [evalEq_denote_true_iff .. |>.mp hEq] at h
      apply evalSlt_denote_false_iff .. |>.mpr h
  case land p q hp hq => simp [eval, denote, hp, hq, evalLand]
  case lor p q hp hq =>
    simp [eval, denote, hp, hq]
    simp only [evalLor, BitStream.and_eq]
    constructor
    · intros heval
      by_cases hp' : p.denote w vars
      · simp [hp']
      · by_cases hq' : q.denote w vars
        · simp [hq']
        · have := hp .. |>.not |>.mpr hp'
          simp [this] at heval
          have := hq .. |>.not |>.mpr hq'
          simp [this] at heval
    · intros hdenote
      rcases hdenote with hp' | hq'
      · have := hp .. |>.mpr hp'
        simp [this]
      · have := hq .. |>.mpr hq'
        simp [this]

/-- info: 'Predicate.eval_eq_denote' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms Predicate.eval_eq_denote


/--
A predicate for a fixed width 'wn' can be expressed as universal quantification
over all width 'w', with a constraint that 'w = wn'
-/
theorem Predicate.width_eq_implies_iff (wn : Nat) {p : Nat → Prop} :
    p wn ↔ (∀ (w : Nat), w = wn → p w) := by
  constructor
  · intros hp h hwn
    subst hwn
    apply hp
  · intros hp
    apply hp
    rfl

/-- To prove that `p` holds, it suffices to show that `p.eval ... = false`. -/
theorem Predicate.denote_of_eval_eq {p : Predicate}
    (heval : ∀ (w : Nat) (vars : List BitStream), p.eval vars w = false) :
    ∀ (w : Nat) (vars : List (BitVec w)), p.denote w vars := by
  intros w vars
  apply p.eval_eq_denote w vars |>.mp (heval w <| vars.map BitStream.ofBitVec)


/-- To prove that `p` holds, it suffices to show that `p.eval ... = false`. -/
theorem Predicate.denote_of_eval_eq_fixedWidth {p : Predicate} (w : Nat)
    (heval : ∀ (vars : List BitStream), p.eval vars w = false) :
    ∀ (vars : List (BitVec w)), p.denote w vars := by
  intros vars
  apply p.eval_eq_denote w vars |>.mp (heval <| vars.map BitStream.ofBitVec)


def Reflect.Map.empty : List (BitVec w) := []

def Reflect.Map.append (w : Nat) (s : BitVec w)  (m : List (BitVec w)) : List (BitVec w) := m.append [s]

def Reflect.Map.get (ix : ℕ) (_ : BitVec w)  (m : List (BitVec w)) : BitVec w := m[ix]!

namespace Simplifications

/-!
Canonicalize `OfNat.ofNat`, `BitVec.ofNat` and `Nat` multiplication to become
`BitVec.ofNat` multiplication with constant on the left.
-/

attribute [bv_circuit_preprocess] BitVec.ofNat_eq_ofNat

/-- Canonicalize multiplications by numerals. -/
@[bv_circuit_preprocess] theorem BitVec.mul_nat_eq_ofNat_mul (x : BitVec w) (n : Nat) :
  x * n = BitVec.ofNat w n * x  := by rw [BitVec.mul_comm]; simp

/-- Canonicalize multiplications by numerals to have constants on the left,
with BitVec.ofNat -/
@[bv_circuit_preprocess] theorem BitVec.nat_mul_eq_ofNat_mul (x : BitVec w) (n : Nat) :
  n * x = BitVec.ofNat w n * x := by rfl

/-- Reassociate multiplication to move constants to left. -/
@[bv_circuit_preprocess] theorem BitVec.mul_ofNat_eq_ofNat_mul (x : BitVec w) (n : Nat) :
  x * (BitVec.ofNat w n) = BitVec.ofNat w n * x := by rw [BitVec.mul_comm]


/-! Normal form for shifts

See that `x <<< (n : Nat)` is strictly more expression than `x <<< BitVec.ofNat w n`,
because in the former case, we can shift by arbitrary amounts, while in the latter case,
we can only shift by numbers upto `2^w`. Therefore, we choose `x <<< (n : Nat)` as our simp
and preprocessing normal form for the tactic.
-/

@[simp] theorem BitVec.shiftLeft_ofNat_eq (x : BitVec w) (n : Nat) :
  x <<< BitVec.ofNat w n = x <<< (n % 2^w) := by simp

/--
Multiplying by an even number `e` is the same as shifting by `1`,
followed by multiplying by half of `e` (the number `n`).
This is used to simplify multiplications into shifts.
-/
theorem BitVec.even_mul_eq_shiftLeft_mul_of_eq_mul_two (w : Nat) (x : BitVec w) (n e : Nat) (he : e = n * 2) :
    (BitVec.ofNat w e) * x = (BitVec.ofNat w n) * (x <<< (1 : Nat)) := by
  apply BitVec.eq_of_toNat_eq
  simp [Nat.shiftLeft_eq, he]
  rcases w with rfl | w
  · simp [Nat.mod_one]
  · congr 1
    rw [Nat.mul_comm x.toNat 2, ← Nat.mul_assoc n]

/--
Multiplying by an odd number `o` is the same as adding `x`, followed by multiplying by `(o - 1) / 2`.
This is used to simplify multiplications into shifts.
-/
theorem BitVec.odd_mul_eq_shiftLeft_mul_of_eq_mul_two_add_one (w : Nat) (x : BitVec w) (n o : Nat)
    (ho : o = n * 2 + 1) : (BitVec.ofNat w o) * x = x + (BitVec.ofNat w n) * (x <<< (1 : Nat)) := by
  apply BitVec.eq_of_toNat_eq
  simp [Nat.shiftLeft_eq, ho]
  rcases w with rfl | w
  · simp [Nat.mod_one]
  · congr 1
    rw [Nat.add_mul]
    simp only [one_mul]
    rw [Nat.mul_assoc, Nat.mul_comm 2]
    omega

@[bv_circuit_preprocess] theorem BitVec.two_mul_eq_add_add (x : BitVec w) : 2#w * x = x + x := by
  apply BitVec.eq_of_toNat_eq;
  simp only [BitVec.ofNat_eq_ofNat, BitVec.toNat_mul, BitVec.toNat_ofNat, Nat.mod_mul_mod,
    BitVec.toNat_add]
  congr
  omega

@[bv_circuit_preprocess] theorem BitVec.two_mul (x : BitVec w) : 2#w * x = x + x := by
  apply BitVec.eq_of_toNat_eq
  simp only [BitVec.toNat_mul, BitVec.toNat_ofNat, Nat.mod_mul_mod, BitVec.toNat_add]
  congr
  omega

@[bv_circuit_preprocess] theorem BitVec.one_mul (x : BitVec w) : 1#w * x = x := by simp

@[bv_circuit_preprocess] theorem BitVec.zero_mul (x : BitVec w) : 0#w * x = 0#w := by simp

-- @[bv_circuit_preprocess] theorem BitVec.neg_one_mul (x : BitVec w) : -1#w * x = -x := by simp

@[bv_circuit_preprocess] theorem BitVec.neg_mul (x y : BitVec w) : (- x) * y = -(x * y) := by simp


open Lean Meta Elab in

/--
Given an equality proof with `lhs = rhs`, return the `rhs`,
and bail out if we are unable to determine it precisely (i.e. no loose metavars).
-/
def getEqRhs (eq : Expr) : MetaM Expr := do
  check eq
  let eq ← whnf <| ← inferType eq
  let some (_ty, _lhs, rhs) := eq.eq? | throwError "unable to infer RHS for equality {eq}"
  let rhs ← instantiateMVars rhs
  rhs.ensureHasNoMVars
  return rhs

open Lean Meta Elab in
/--
This needs to be a pre-simproc, because we want to rewrite `k * x`
repeatedly into smaller multiplications:
  + rewrite into `x + ((k/2) * (x <<< 1))` if `k` odd.
  + rewrite into `(k/2) * (x <<< 1) if k even.

Since we get a smaller multiplication with `k/2`, we need it to be a pre-simproc so we recurse
into the RHS expression.
-/
simproc↓ [bv_circuit_preprocess] shiftLeft_break_down ((BitVec.ofNat _ _) * (_ : BitVec _)) := fun x => do
  match_expr x with
  | HMul.hMul _bv _bv _bv _inst kbv x =>
    let_expr BitVec.ofNat _w k := kbv | return .continue
    let some kVal ← Meta.getNatValue? k | return .continue
    /- base cases, will be taken care of by rewrite theorems -/
    if kVal == 0 || kVal == 1 then return .continue
    let thmName := if kVal % 2 == 0 then
      mkConst ``BitVec.even_mul_eq_shiftLeft_mul_of_eq_mul_two
    else
      mkConst ``BitVec.odd_mul_eq_shiftLeft_mul_of_eq_mul_two_add_one
    let eqProof := mkAppN thmName
      #[_w, x, mkNatLit <| Nat.div2 kVal, mkNatLit kVal,  (← mkEqRefl k)]
    return .visit { proof? := eqProof, expr := ← getEqRhs eqProof }
  | _ => return .continue

open Lean Elab Meta
def runPreprocessing (g : MVarId) : MetaM (Option MVarId) := do
  let some ext ← (getSimpExtension? `bv_circuit_preprocess)
    | throwError m!"'bv_circuit_preprocess' simp attribute not found!"
  let theorems ← ext.getTheorems
  let some ext ← (Simp.getSimprocExtension? `bv_circuit_preprocess)
    | throwError m!" 'bv_circuit_preprocess' simp attribute not found!"
  let simprocs ← ext.getSimprocs
  let config : Simp.Config := { }
  let config := { config with failIfUnchanged := false }
  let ctx ← Simp.mkContext (config := config)
    (simpTheorems := #[theorems])
    (congrTheorems := ← Meta.getSimpCongrTheorems)
  match ← simpGoal g ctx (simprocs := #[simprocs]) with
  | (none, _) => return none
  | (some (_newHyps, g'), _) => pure g'

end Simplifications

namespace NNF

open Lean Elab Meta

/-- convert goal to negation normal form, by running appropriate lemmas from `bv_circuit_nnf`, and reverting all hypothese. -/
def runNNFSimpSet (g : MVarId) : MetaM (Option MVarId) := do
  let some ext ← (getSimpExtension? `bv_circuit_nnf)
    | throwError m!"[bv_nnf] Error: 'bv_circuit_nnf' simp attribute not found!"
  let theorems ← ext.getTheorems
  let some ext ← (Simp.getSimprocExtension? `bv_circuit_nnf)
    | throwError m!"[bv_nnf] Error: 'bv_circuit_nnf' simp attribute not found!"
  let simprocs ← ext.getSimprocs
  let config : Simp.Config := { Simp.neutralConfig with
    failIfUnchanged   := false,
  }
  let ctx ← Simp.mkContext (config := config)
    (simpTheorems := #[theorems])
    (congrTheorems := ← Meta.getSimpCongrTheorems)
  match ← simpGoal g ctx (simprocs := #[simprocs]) with
  | (none, _) => return none
  | (some (_newHyps, g'), _) => pure g'

open Lean Elab Meta Tactic in
/-- Convert the goal into negation normal form. -/
elab "bv_nnf" : tactic => do
  liftMetaTactic fun g => do
    match ← runNNFSimpSet g with
    | none => return []
    | some g => do
      -- revert after running the simp-set, so that we don't transform
      -- with `forall_and : (∀ x, p x ∧ q x) ↔ (∀ x, p x) ∧ (∀ x, q x)`.
      -- TODO(@bollu): This opens up an interesting possibility, where we can handle smaller problems
      -- by just working on disjunctions.
      -- let g ← g.revertAll
      return [g]

attribute [bv_circuit_nnf] BitVec.not_lt
attribute [bv_circuit_nnf] BitVec.not_le

@[bv_circuit_nnf]
theorem implies_eq_not_a_or_b (a b : Prop) : (a → b) = (¬ a ∨ b) := by
  by_cases a
  case pos h => simp [h]
  case neg h => simp [h]

@[bv_circuit_nnf]
theorem sle_iff_slt_eq_false {a b : BitVec w} : a.slt b = false ↔ b.sle a := by
  constructor <;>
  intros h <;>
  simp [BitVec.sle, BitVec.slt] at h ⊢ <;>
  omega

@[bv_circuit_nnf]
theorem slt_iff_sle_eq_false {a b : BitVec w} : a.sle b = false ↔ b.slt a := by
  constructor <;>
  intros h <;>
  simp [BitVec.sle, BitVec.slt] at h ⊢ <;>
  omega

/-!
Normalization theorems for the `grind` tactic.

We are also going to use simproc's in the future.
-/

-- Not
attribute [bv_circuit_nnf] Classical.not_not

@[bv_circuit_nnf] theorem not_eq_eq {α : Sort u} (a b : α) : (¬ (a = b)) = (a ≠ b) := by simp

-- Iff
@[bv_circuit_nnf] theorem iff_eq (p q : Prop) : (p ↔ q) = (p = q) := by
  by_cases p <;> by_cases q <;> simp [*]

-- Eq
attribute [bv_circuit_nnf] eq_self heq_eq_eq

-- Prop equality
@[bv_circuit_nnf] theorem eq_true_eq (p : Prop) : (p = True) = p := by simp
@[bv_circuit_nnf] theorem eq_false_eq (p : Prop) : (p = False) = ¬p := by simp
@[bv_circuit_nnf] theorem not_eq_prop (p q : Prop) : (¬(p = q)) = (p = ¬q) := by
  by_cases p <;> by_cases q <;> simp [*]

-- True
attribute [bv_circuit_nnf] not_true

-- False
attribute [bv_circuit_nnf] not_false_eq_true

-- Remark: we disabled the following normalization rule because we want this information when implementing splitting heuristics
-- Implication as a clause
theorem imp_eq (p q : Prop) : (p → q) = (¬ p ∨ q) := by
  by_cases p <;> by_cases q <;> simp [*]

@[bv_circuit_nnf] theorem true_imp_eq (p : Prop) : (True → p) = p := by simp
@[bv_circuit_nnf] theorem false_imp_eq (p : Prop) : (False → p) = True := by simp
@[bv_circuit_nnf] theorem imp_true_eq (p : Prop) : (p → True) = True := by simp
@[bv_circuit_nnf] theorem imp_false_eq (p : Prop) : (p → False) = ¬p := by simp
@[bv_circuit_nnf] theorem imp_self_eq (p : Prop) : (p → p) = True := by simp

-- And
@[bv_circuit_nnf↓] theorem not_and (p q : Prop) : (¬(p ∧ q)) = (¬p ∨ ¬q) := by
  by_cases p <;> by_cases q <;> simp [*]
attribute [bv_circuit_nnf] and_true true_and and_false false_and and_assoc

-- Or
attribute [bv_circuit_nnf↓] not_or
attribute [bv_circuit_nnf] or_true true_or or_false false_or or_assoc

-- ite
attribute [bv_circuit_nnf] ite_true ite_false
@[bv_circuit_nnf↓] theorem not_ite {_ : Decidable p} (q r : Prop) : (¬ite p q r) = ite p (¬q) (¬r) := by
  by_cases p <;> simp [*]

@[bv_circuit_nnf] theorem ite_true_false {_ : Decidable p} : (ite p True False) = p := by
  by_cases p <;> simp

@[bv_circuit_nnf] theorem ite_false_true {_ : Decidable p} : (ite p False True) = ¬p := by
  by_cases p <;> simp

-- Forall
@[bv_circuit_nnf↓] theorem not_forall (p : α → Prop) : (¬∀ x, p x) = ∃ x, ¬p x := by simp
attribute [bv_circuit_nnf] forall_and

-- Exists
@[bv_circuit_nnf↓] theorem not_exists (p : α → Prop) : (¬∃ x, p x) = ∀ x, ¬p x := by simp
attribute [bv_circuit_nnf] exists_const exists_or exists_prop exists_and_left exists_and_right

-- Bool cond
@[bv_circuit_nnf] theorem cond_eq_ite (c : Bool) (a b : α) : cond c a b = ite c a b := by
  cases c <;> simp [*]

-- Bool or
attribute [bv_circuit_nnf]
  Bool.or_false Bool.or_true Bool.false_or Bool.true_or Bool.or_eq_true Bool.or_assoc

-- Bool and
attribute [bv_circuit_nnf]
  Bool.and_false Bool.and_true Bool.false_and Bool.true_and Bool.and_eq_true Bool.and_assoc

-- Bool not
attribute [bv_circuit_nnf]
  Bool.not_not

-- beq
attribute [bv_circuit_nnf] beq_iff_eq

-- bne
attribute [bv_circuit_nnf] bne_iff_ne

-- Bool not eq true/false
attribute [bv_circuit_nnf] Bool.not_eq_true Bool.not_eq_false

-- decide
attribute [bv_circuit_nnf] decide_eq_true_eq decide_not not_decide_eq_true

-- Nat LE
attribute [bv_circuit_nnf] Nat.le_zero_eq

-- Nat/Int LT
@[bv_circuit_nnf] theorem Nat.lt_eq (a b : Nat) : (a < b) = (a + 1 ≤ b) := by
  simp [Nat.lt, LT.lt]

@[bv_circuit_nnf] theorem Int.lt_eq (a b : Int) : (a < b) = (a + 1 ≤ b) := by
  simp [Int.lt, LT.lt]

-- GT GE
attribute [bv_circuit_nnf] GT.gt GE.ge

-- Succ
attribute [bv_circuit_nnf] Nat.succ_eq_add_one

/--
warning: declaration uses 'sorry'
---
info: w : ℕ
⊢ (∀ (x x_1 : BitVec w), x_1 ≤ x) ∧ ∀ (x x_1 : BitVec w), x ≤ x_1 ∨ x_1 < x ∨ x ≤ x_1 ∨ x ≠ x_1
-/
#guard_msgs in example : ∀ (a b : BitVec w),  ¬ (a < b ∨ a > b ∧ a ≤ b ∧ a > b ∧ (¬ (a ≠ b))) := by
 bv_nnf;
 trace_state; sorry

/--
warning: declaration uses 'sorry'
---
info: w : ℕ
⊢ ∀ (a b : BitVec w), a &&& b ≠ 0#w ∨ a = b
-/
#guard_msgs in example : ∀ (a b : BitVec w), a &&& b = 0#w → a = b := by
 bv_nnf; trace_state; sorry

end NNF

/-
Armed with the above, we write a proof by reflection principle.
This is adapted from Bits/Fast/Tactic.lean, but is cleaned up to build 'nice' looking environments
for reflection, rather than ones based on hashing the 'fvar', which can also have weird corner cases due to hash collisions.

TODO(@bollu): For now, we don't reflects constants properly, since we don't have arbitrary constants in the term language (`Term`).
TODO(@bollu): We also assume that the goals are in negation normal form, and if we not, we bail out. We should make sure that we write a tactic called `nnf` that transforms goals to negation normal form.
-/

namespace Reflect
open Lean Meta Elab Tactic

inductive CircuitBackend
/-- Pure lean implementation, verified. -/
| lean
/-- bv_decide based backend. Currently unverified. -/
| cadical (maxIter : Nat := 4)
/-- Dry run, do not execute and close proof with `sorry` -/
| dryrun
deriving Repr, DecidableEq

/-- Tactic options for bv_automata_circuit -/
structure Config where
  /--
  The upper bound on the size of circuits in the FSM, beyond which the tactic will bail out on an error.
  This is useful to prevent the tactic from taking oodles of time cruncing on goals that
  build large state spaces, which can happen in the presence of tactics.
  -/
  circuitSizeThreshold : Nat := 200

  /--
  The upper bound on the state space of the FSM, beyond which the tactic will bail out on an error.
  See also `Config.circuitSizeThreshold`.
  -/
  stateSpaceSizeThreshold : Nat := 20
  /--
  Whether the tactic should used a specialized solver for fixed-width constraints.
  -/
  fastFixedWidth : Bool := false
  /--
  Whether the tactic should use the (currently unverified) bv_decide based backend for solving constraints.
  -/
  backend : CircuitBackend := .lean

/-- Default user configuration -/
def Config.default : Config := {}

/-- The free variables in the term that is reflected. -/
structure ReflectMap where
  /-- Map expressions to their index in the eventual `Reflect.Map`. -/
  exprs : Std.HashMap Expr Nat


instance : EmptyCollection ReflectMap where
  emptyCollection := { exprs := ∅ }

abbrev ReflectedExpr := Expr

/--
Insert expression 'e' into the reflection map. This returns the map,
as well as the denoted term.
-/
def ReflectMap.findOrInsertExpr (m : ReflectMap) (e : Expr) : _root_.Term × ReflectMap :=
  let (ix, m) := match m.exprs.get? e with
    | some ix =>  (ix, m)
    | none =>
      let ix := m.exprs.size
      (ix, { m with exprs := m.exprs.insert e ix })
  -- let e :=  mkApp (mkConst ``Term.var) (mkNatLit ix)
  (Term.var ix, m)


/--
Convert the meta-level `ReflectMap` into an object level `Reflect.Map` by
repeatedly calling `Reflect.Map.empty` and `Reflect.Map.set`.
-/
def ReflectMap.toExpr (xs : ReflectMap) (w : Expr) : MetaM ReflectedExpr := do
  let mut out := mkApp (mkConst ``Reflect.Map.empty) w
  let exprs := xs.exprs.toArray.qsort (fun ei ej => ei.2 < ej.2)
  for (e, _) in exprs do
    -- The 'exprs' will be in order, with 0..n
    /- Append the expressions into the array -/
    out := mkAppN (mkConst ``Reflect.Map.append) #[w, e, out]
  return out

instance : ToMessageData ReflectMap where
  toMessageData exprs := Id.run do
    -- sort in order of index.
    let es := exprs.exprs.toArray.qsort (fun a b => a.2 < b.2)
    let mut lines := es.map (fun (e, i) => m!"{i}→{e}")
    return m!"[" ++ m!" ".joinSep lines.toList ++ m!"]"

/--
If we have variables in the `ReflectMap` that are not FVars,
then we will throw a warning informing the user that this will be treated as a symbolic variable.
-/
def ReflectMap.throwWarningIfUninterpretedExprs (xs : ReflectMap) : MetaM Unit := do
  let mut out? : Option MessageData := none
  let header := m!"Tactic has not understood the following expressions, and will treat them as symbolic:"
  -- Order the expressions so we get stable error messages.
  let exprs := xs.exprs.toArray.qsort (fun ei ej => ei.1.lt ej.1)

  for (e, _) in exprs do
    if e.isFVar then continue
    let eshow := indentD m!"- '{e}'"
    out? := match out? with
      | .none => header ++ Format.line ++ eshow
      | .some out => .some (out ++ eshow)
  let .some out := out? | return ()
  logWarning out

/--
Result of reflection, where we have a collection of bitvector variables,
along with the bitwidth and the final term.
-/
structure ReflectResult (α : Type) where
  /-- Map of 'free variables' in the bitvector expression,
  which are indexed as Term.var. This array is used to build the environment for decide.
  -/
  bvToIxMap : ReflectMap
  e : α

instance [ToMessageData α] : ToMessageData (ReflectResult α) where
  toMessageData result := m!"{result.e} {result.bvToIxMap}"



/--
info: ∀ {w : Nat} (a b : BitVec w),
  @Eq (BitVec w) (@HAdd.hAdd (BitVec w) (BitVec w) (BitVec w) (@instHAdd (BitVec w) (@BitVec.instAdd w)) a b)
    (BitVec.ofNat w (@OfNat.ofNat Nat 0 (instOfNatNat 0))) : Prop
-/
#guard_msgs in set_option pp.explicit true in
#check ∀ {w : Nat} (a b: BitVec w), a + b = 0#w

/--
info: ∀ {w : Nat} (a : BitVec w),
  @Eq (BitVec w) (@Neg.neg (BitVec w) (@BitVec.instNeg w) a)
    (BitVec.ofNat w (@OfNat.ofNat Nat 0 (instOfNatNat 0))) : Prop
-/
#guard_msgs in set_option pp.explicit true in
#check ∀ {w : Nat} (a : BitVec w), - a = 0#w

/--
info: ∀ {w : Nat} (a : BitVec w) (n : Nat),
  @Eq (BitVec w) (@HShiftLeft.hShiftLeft (BitVec w) Nat (BitVec w) (@BitVec.instHShiftLeftNat w) a n)
    (BitVec.ofNat w (@OfNat.ofNat Nat 0 (instOfNatNat 0))) : Prop
-/
#guard_msgs in set_option pp.explicit true in
#check ∀ {w : Nat} (a : BitVec w) (n : Nat), a <<< n = 0#w


/--
info: ∀ {w : Nat} (a : BitVec w),
  @LT.lt (BitVec w) (@instLTBitVec w) a (BitVec.ofNat w (@OfNat.ofNat Nat 0 (instOfNatNat 0))) : Prop
-/
#guard_msgs in set_option pp.explicit true in
#check ∀ {w : Nat} (a : BitVec w),  a  < 0#w

/--
info: ∀ {w : Nat} (a : BitVec w),
  @LE.le (BitVec w) (@instLEBitVec w) a (BitVec.ofNat w (@OfNat.ofNat Nat 0 (instOfNatNat 0))) : Prop
-/
#guard_msgs in set_option pp.explicit true in
#check ∀ {w : Nat} (a : BitVec w),  a  ≤ 0#w

/--
info: ∀ {w : Nat} (a : BitVec w),
  @Eq Bool (@BitVec.slt w a (BitVec.ofNat w (@OfNat.ofNat Nat 0 (instOfNatNat 0)))) true : Prop
-/
#guard_msgs in set_option pp.explicit true in
#check ∀ {w : Nat} (a : BitVec w),  a.slt 0#w


def reflectAtomUnchecked (map : ReflectMap) (_w : Expr) (e : Expr) : MetaM (ReflectResult _root_.Term) := do
  let (e, map) := map.findOrInsertExpr e
  return { bvToIxMap := map, e := e }


/--
Return a new expression that this is **defeq** to, along with the expression of the environment that this needs.
Crucially, when this succeeds, this will be in terms of `term`.
and furthermore, it will reflect all terms as variables.

Precondition: we assume that this is called on bitvectors.
-/
partial def reflectTermUnchecked (map : ReflectMap) (w : Expr) (e : Expr) : MetaM (ReflectResult _root_.Term) := do
  if let some (v, _bvTy) ← getOfNatValue? e ``BitVec then
    return { bvToIxMap := map, e := Term.ofNat v }
  -- TODO: bitvector contants.
  match_expr e with
  | BitVec.ofInt _wExpr iExpr =>
    let i ← getIntValue? iExpr
    match i with
    | _ =>
      let (e, map) := map.findOrInsertExpr e
      return { bvToIxMap := map, e := e }
  | BitVec.ofNat _wExpr nExpr =>
    let n ← getNatValue? nExpr
    match n with
    | .some 0 =>
      return {bvToIxMap := map, e := Term.zero }
    | .some 1 =>
      let _ := (mkConst ``Term.one)
      return {bvToIxMap := map, e := Term.one }
    | .some n =>
      return { bvToIxMap := map, e := Term.ofNat n }
    | none =>
      logWarning "expected concrete BitVec.ofNat, found symbol '{n}', creating free variable"
      reflectAtomUnchecked map w e

  | HAnd.hAnd _bv _bv _bv _inst a b =>
      let a ← reflectTermUnchecked map w a
      let b ← reflectTermUnchecked a.bvToIxMap w b
      let out := Term.and a.e b.e
      return { b with e := out }
  | HOr.hOr _bv _bv _bv _inst a b =>
      let a ← reflectTermUnchecked map w a
      let b ← reflectTermUnchecked a.bvToIxMap w b
      let out := Term.or a.e b.e
      return { b with e := out }
  | HXor.hXor _bv _bv _bv _inst a b =>
      let a ← reflectTermUnchecked map w a
      let b ← reflectTermUnchecked a.bvToIxMap w b
      let out := Term.xor a.e b.e
      return { b with e := out }
  | Complement.complement _bv _inst a =>
      let a ← reflectTermUnchecked map w a
      let out := Term.not a.e
      return { a with e := out }
  | HAdd.hAdd _bv _bv _bv _inst a b =>
      let a ← reflectTermUnchecked map w a
      let b ← reflectTermUnchecked a.bvToIxMap w b
      let out := Term.add a.e b.e
      return { b with e := out }
  | HShiftLeft.hShiftLeft _bv _nat _bv _inst a n =>
      let a ← reflectTermUnchecked map w a
      let some n ← getNatValue? n
        | throwError "expected shiftLeft by natural number, found symbolic shift amount '{n}' at '{indentD e}'"
      return { a with e := Term.shiftL a.e n }

  | HSub.hSub _bv _bv _bv _inst a b =>
      let a ← reflectTermUnchecked map w a
      let b ← reflectTermUnchecked a.bvToIxMap w b
      let out := Term.sub a.e b.e
      return { b with e := out }
  | Neg.neg _bv _inst a =>
      let a ← reflectTermUnchecked map w a
      let out := Term.neg a.e
      return { a with e := out }
  -- incr
  -- decr
  | _ =>
    let (e, map) := map.findOrInsertExpr e
    return { bvToIxMap := map, e := e }

set_option pp.explicit true in
/--
info: ∀ {w : Nat} (a b : BitVec w), Or (@Eq (BitVec w) a b) (And (@Ne (BitVec w) a b) (@Eq (BitVec w) a b)) : Prop
-/
#guard_msgs in
#check ∀ {w : Nat} (a b : BitVec w), a = b ∨ (a ≠ b) ∧ a = b

/-- Return a new expression that this is defeq to, along with the expression of the environment that this needs, under which it will be defeq. -/
partial def reflectPredicateAux (bvToIxMap : ReflectMap) (e : Expr) (wExpected : Expr) : MetaM (ReflectResult Predicate) := do
  match_expr e with
  | Eq α a b =>
    match_expr α with
    | Nat =>
       -- support width equality constraints
      -- TODO: canonicalize 'a = w' into 'w = a'.
      if wExpected != a then
        throwError "Only Nat expressions allowed are '{wExpected} ≠ <concrete value>'. Found {indentD e}."
      let some natVal ← Lean.Meta.getNatValue? b
        | throwError "Expected '{wExpected} ≠ <concrete width>', found symbolic width {indentD b}."
      let out := Predicate.widthEq natVal
      return { bvToIxMap := bvToIxMap, e := out }

    | BitVec w =>
      let a ←  reflectTermUnchecked bvToIxMap w a
      let b ← reflectTermUnchecked a.bvToIxMap w b
      return { bvToIxMap := b.bvToIxMap, e := Predicate.eq a.e b.e }
    | Bool =>
      -- Sadly, recall that slt, sle are of type 'BitVec w → BitVec w → Bool',
      -- so we get goal states of them form 'a <ₛb = true'.
      -- So we need to match on 'Eq _ true' where '_' is 'slt'.
      -- This makes me unhappy too, but c'est la vie.
      let_expr true := b
        | throwError "only boolean conditionals allowed are 'bv.slt bv = true', 'bv.sle bv = true'. Found {indentD e}."
      match_expr a with
      | BitVec.slt w a b =>
        let a ← reflectTermUnchecked bvToIxMap w a
        let b ← reflectTermUnchecked a.bvToIxMap w b
        return { bvToIxMap := b.bvToIxMap, e := Predicate.slt a.e b.e }
      | BitVec.sle w a b =>
        let a ← reflectTermUnchecked bvToIxMap w a
        let b ← reflectTermUnchecked a.bvToIxMap w b
        return { bvToIxMap := b.bvToIxMap, e := Predicate.sle a.e b.e }
      | _ =>
        throwError "unknown boolean conditional, expected 'bv.slt bv = true' or 'bv.sle bv = true'. Found {indentD e}"
    | _ =>
      throwError "unknown equality kind, expected 'bv = bv' or 'bv.slt bv = true' or 'bv.sle bv = true'. Found {indentD e}"
  | Ne α a b =>
    /- Support width constraints with α = Nat -/
    match_expr α with
    | Nat => do
      -- TODO: canonicalize 'a ≠ w' into 'w ≠ a'.
      if wExpected != a then
        throwError "Only Nat expressions allowed are '{wExpected} ≠ <concrete value>'. Found {indentD e}."
      let some natVal ← Lean.Meta.getNatValue? b
        | throwError "Expected '{wExpected} ≠ <concrete width>', found symbolic width {indentD b}."
      let out := Predicate.widthNeq natVal
      return { bvToIxMap := bvToIxMap, e := out }
    | BitVec w =>
      let a ← reflectTermUnchecked bvToIxMap w a
      let b ← reflectTermUnchecked a.bvToIxMap w b
      return { bvToIxMap := b.bvToIxMap, e := Predicate.neq a.e b.e }
    | _ =>
      throwError "Expected typeclass to be 'BitVec w' / 'Nat', found '{indentD α}' in {e} when matching against 'Ne'"
  | LT.lt α _inst a b =>
    let_expr BitVec w := α | throwError "Expected typeclass to be BitVec w, found '{indentD α}' in {indentD e} when matching against 'LT.lt'"
    let a ← reflectTermUnchecked bvToIxMap w a
    let b ← reflectTermUnchecked a.bvToIxMap w b
    return { bvToIxMap := b.bvToIxMap, e := Predicate.ult a.e b.e }
  | LE.le α _inst a b =>
    let_expr BitVec w := α | throwError "Expected typeclass to be BitVec w, found '{indentD α}' in {indentD e} when matching against 'LE.le'"
    let a ← reflectTermUnchecked bvToIxMap w a
    let b ← reflectTermUnchecked a.bvToIxMap w b
    return { bvToIxMap := b.bvToIxMap, e := Predicate.ule a.e b.e }
  | Or p q =>
    let p ← reflectPredicateAux bvToIxMap p wExpected
    let q ← reflectPredicateAux p.bvToIxMap q wExpected
    let out := Predicate.lor p.e q.e
    return { q with e := out }
  | And p q =>
    let p ← reflectPredicateAux bvToIxMap p wExpected
    let q ← reflectPredicateAux p.bvToIxMap q wExpected
    let out := Predicate.land p.e q.e
    return { q with e := out }
  | _ =>
     throwError "expected predicate over bitvectors (no quantification), found:  {indentD e}"

/-- Name of the tactic -/
def tacName : String := "bv_automata_circuit"

abbrev WidthToExprMap := Std.HashMap Expr Expr

/--
Find all bitwidths implicated in the given expression.
Maps each length (the key) to an expression of that length.

Find all bitwidths implicated in the given expression,
by visiting subexpressions with visitExpr:
    O(size of expr × inferType)
-/
def findExprBitwidths (target : Expr) : MetaM WidthToExprMap := do
  let (_, out) ← StateT.run (go target) ∅
  return out
  where
    go (target : Expr) : StateT WidthToExprMap MetaM Unit := do
      -- Creates fvars when going inside binders.
      forEachExpr target fun e => do
        match_expr ← inferType e with
        | BitVec n =>
          -- TODO(@bollu): do we decide to normalize `n`? upto what?
          modify (fun arr => arr.insert n.cleanupAnnotations e)
        | _ => return ()

/-- Return if expression 'e' is a bitvector of bitwidth 'w' -/
private def Expr.isBitVecOfWidth (e : Expr) (w : Expr) : MetaM Bool := do
  match_expr ← inferType e with
  | BitVec w' => return w == w'
  | _ => return false


/-- Revert all bitwidths of a given bitwidth and then run the continuation 'k'.
This allows
-/
def revertBVsOfWidth (g : MVarId) (w : Expr) : MetaM MVarId := g.withContext do
  let mut reverts : Array FVarId := #[]
  for d in ← getLCtx do
    if ← Expr.isBitVecOfWidth d.type w then
      reverts := reverts.push d.fvarId
  /- revert all the bitvectors of the given width in one fell swoop. -/
  let (_fvars, g) ← g.revert reverts
  return g

/-- generalize our mapping to get a single fvar -/
def generalizeMap (g : MVarId) (e : Expr) : MetaM (FVarId × MVarId) :=  do
  let (fvars, g) ← g.generalize #[{ expr := e : GeneralizeArg}]
  --eNow target no longer depends on the particular bitvectors
  if h : fvars.size = 1 then
    return (fvars[0], g)
  throwError"expected a single free variable from generalizing map {e}, found multiple..."

/--
Revert all hypotheses that have to do with bitvectors, so that we can use them.

For now, we choose to revert all propositional hypotheses.
The issue is as follows: Since our reflection fragment only deals with
goals in negation normal form, the naive algorithm would run an NNF pass
and then try to reflect the hyp before reverting it. This is expensive and annoying to implement.

Ideally, we would have a pass that quickly walks an expression to cheaply
ee if it's in the BV fragment, and revert it if it is.
For now, we use a sound overapproximation and revert everything.
-/
def revertBvHyps (g : MVarId) : MetaM MVarId := do
  let (_, g) ← g.revert (← g.getNondepPropHyps)
  return g

namespace BvDecide
open Std Sat AIG in

/--
Convert a 'Circuit α' into an 'AIG α' in order to reuse bv_decide's
bitblasting capabilities.
-/
@[nospecialize]
def _root_.Circuit.toAIG [DecidableEq α] [Fintype α] [Hashable α] (c : Circuit α) (aig : AIG α) :
    ExtendingEntrypoint aig :=
  match c with
  | .fals => ⟨aig.mkConstCached false, by apply  LawfulOperator.le_size⟩
  | .tru => ⟨aig.mkConstCached true, by apply  LawfulOperator.le_size⟩
  | .var b v =>
    let out := mkAtomCached aig v
    have AtomLe := LawfulOperator.le_size (f := mkAtomCached) aig v
    if b then
      ⟨out, by simp [out]; omega⟩
    else
      let notOut := mkNotCached out.aig out.ref
      have NotLe := LawfulOperator.le_size (f := mkNotCached) out.aig out.ref
      ⟨notOut, by simp only [notOut, out] at NotLe AtomLe ⊢; omega⟩
  | .and l r =>
    let ⟨⟨aig, lhsRef⟩, lextend⟩ := l.toAIG aig
    let ⟨⟨aig, rhsRef⟩, rextend⟩ := r.toAIG aig
    let lhsRef := lhsRef.cast <| by
      dsimp only at rextend ⊢
      omega
    let input := ⟨lhsRef, rhsRef⟩
    let ret := aig.mkAndCached input
    have Lawful := LawfulOperator.le_size (f := mkAndCached) aig input
    ⟨ret, by dsimp only [ret] at lextend rextend ⊢; omega⟩
  | .or l r =>
    let ⟨⟨aig, lhsRef⟩, lextend⟩ := l.toAIG aig
    let ⟨⟨aig, rhsRef⟩, rextend⟩ := r.toAIG aig
    let lhsRef := lhsRef.cast <| by
      dsimp only at rextend ⊢
      omega
    let input := ⟨lhsRef, rhsRef⟩
    let ret := aig.mkOrCached input
    have Lawful := LawfulOperator.le_size (f := mkOrCached) aig input
    ⟨ret, by dsimp only [ret] at lextend rextend ⊢; omega⟩
  | .xor l r =>
    let ⟨⟨aig, lhsRef⟩, lextend⟩ := l.toAIG aig
    let ⟨⟨aig, rhsRef⟩, rextend⟩ := r.toAIG aig
    let lhsRef := lhsRef.cast <| by
      dsimp only at rextend ⊢
      omega
    let input := ⟨lhsRef, rhsRef⟩
    let ret := aig.mkXorCached input
    have Lawful := LawfulOperator.le_size (f := mkXorCached) aig input
    ⟨ret, by dsimp only [ret] at lextend rextend ⊢; omega⟩
/-!
Helpers to use `bv_decide` as a solver-in-the-loop for the reflection proof.
-/

def cadicalTimeoutSec : Nat := 1000

attribute [nospecialize] Circuit.toAIG
-- attribute [nospecialize] Std.Sat.AIG.Entrypoint.relabelNat'

open Std Sat AIG Tactic BVDecide Frontend in
@[nospecialize]
def checkCircuitSatAux [DecidableEq α] [Hashable α] [Fintype α] (c : Circuit α) : TermElabM Bool := do
  let cfg : BVDecideConfig := { timeout := cadicalTimeoutSec }
  IO.FS.withTempFile fun _ lratFile => do
    let cfg ← BVDecide.Frontend.TacticContext.new lratFile cfg
    let ⟨entrypoint, _hEntrypoint⟩ := c.toAIG AIG.empty
    let ⟨entrypoint, _labelling⟩ := entrypoint.relabelNat'
    let cnf := toCNF entrypoint
    let out ← runExternal cnf cfg.solver cfg.lratPath
      (trimProofs := true)
      (timeout := cadicalTimeoutSec)
      (binaryProofs := true)
    match out with
    | .error _model => return true
    | .ok _cert => return false


open Std Sat AIG Tactic BVDecide Frontend in
@[nospecialize]
def checkCircuitTautoAuxImpl [DecidableEq α] [Hashable α] [Fintype α] (c : Circuit α) : TermElabM Bool := do
  let cfg : BVDecideConfig := { timeout := cadicalTimeoutSec }
  IO.FS.withTempFile fun _ lratFile => do
    let cfg ← BVDecide.Frontend.TacticContext.new lratFile cfg
    let c := ~~~ c -- we're checking TAUTO, so check that negation is UNSAT.
    let ⟨entrypoint, _hEntrypoint⟩ := c.toAIG AIG.empty
    let ⟨entrypoint, _labelling⟩ := entrypoint.relabelNat'
    let cnf := toCNF entrypoint
    let out ← runExternal cnf cfg.solver cfg.lratPath
      (trimProofs := true)
      (timeout := cadicalTimeoutSec)
      (binaryProofs := true)
    match out with
    | .error _model => return false
    | .ok _cert => return true

@[implemented_by checkCircuitTautoAuxImpl, nospecialize]
def checkCircuitTautoAux {α : Type} [DecidableEq α] [Hashable α] [Fintype α] (c : Circuit α) : TermElabM Bool := do
  return false

/--
An axiom that tracks that a theorem is true because of our currently unverified
'decideIfZerosM' decision procedure.
-/
axiom decideIfZerosMAx {p : Prop} : p

/--
An inductive type representing the variables in the unrolled FSM circuit,
where we unroll for 'n' steps.
-/
structure Inputs (ι : Type) (n : Nat) : Type  where
  ix : Fin n
  input : ι
deriving DecidableEq, Hashable


namespace Inputs

def latest (i : ι) : Inputs ι (n+1) where
  ix := ⟨n, by omega⟩
  input := i

def castLe (i : Inputs ι n) (hn : n ≤ n') : Inputs ι n' where
  ix := ⟨i.ix, by omega⟩
  input := i.input

def map (f : ι → ι') (i : Inputs ι n) : Inputs ι' n where
  ix := i.ix
  input := f i.input

def univ [DecidableEq ι] [Fintype ι] (n : Nat) :
    { univ : Finset (Inputs ι n) // ∀ x : Inputs ι n, x ∈ univ } :=
  match n with
  | 0 =>
    let out : Finset (Inputs ι 0) := {}
    ⟨out, by
      intros x
      apply x.ix.elim0
    ⟩
  | n + 1 =>
    sorry

instance [DecidableEq ι] [Fintype ι] :
    Fintype (Inputs ι n) where
  elems := univ n |>.val
  complete := univ n |>.property

/-- Format an Inputs -/
def format (f : ι → Format) (is : Inputs ι n) : Format :=
  f!"⟨{f is.input}@{is.ix}⟩"

end Inputs


inductive Vars (σ : Type) (ι : Type) (n : Nat)
| state (s : σ)
| inputs (is : Inputs ι n)
deriving DecidableEq, Hashable

instance [DecidableEq σ] [DecidableEq ι] [Fintype σ] [Fintype ι] : Fintype (Vars σ ι n) where
  elems :=
    let ss : Finset σ := Finset.univ
    let ss : Finset (Vars σ ι n) := ss.map ⟨Vars.state, by intros s s'; simp⟩
    let ii : Finset (Inputs ι n) := Finset.univ
    let ii : Finset (Vars σ ι n) := ii.map ⟨Vars.inputs, by intros ii ii'; simp⟩
    ss ∪ ii
  complete := by
    intros x
    simp
    rcases x with s | i  <;> simp

def Vars.format (fσ : σ → Format) (fι : ι → Format) {n : Nat} (v : Vars σ ι n) : Format :=
  match v with
  | .state s => fσ s
  | .inputs is => is.format fι

@[nospecialize]
partial def decideIfZerosAuxTermElabM {arity : Type _}
    [DecidableEq arity] [Fintype arity] [Hashable arity]
    (iter : Nat) (maxIter : Nat)
    (p : FSM arity)
    (c0K : Circuit (Vars p.α arity iter))
    (cK : Circuit (Vars p.α arity iter))
    (safetyProperty : Circuit (Vars p.α arity iter)) : TermElabM Bool := do
  logInfo s!"## K-induction (iter {iter})"
  if iter ≥ maxIter then
    logInfo s!"ran out of iterations, quitting"
    return false
  let cKWithInit : Circuit (Vars Empty arity iter) := cK.assignVars fun v _hv =>
    match v with
    | .state a => .inr (p.initCarry a) -- assign init state
    | .inputs is => .inl (.inputs is)
  let formatα : p.α → Format := fun s => "s" ++ formatDecEqFinset s
  let formatEmpty : Empty → Format := fun e => e.elim
  let formatArity : arity → Format := fun i => "i" ++ formatDecEqFinset i
  logInfo m!"safety property circuit: {formatCircuit (Vars.format formatEmpty formatArity) cKWithInit}"
  if ← checkCircuitSatAux cKWithInit
  then
    IO.println s!"Safety property failed on initial state."
    return false
  else
    IO.println s!"Safety property succeeded on initial state. Building next state circuit..."
    -- circuit of the output at state (k+1)
    let cKSucc : Circuit (Vars p.α arity (iter + 1)) :=
      cK.bind fun v =>
        match v with
        | .state a => p.nextBitCirc (some a) |>.map fun v =>
          match v with
          | .inl a => .state a
          | .inr x => .inputs <| Inputs.latest x
        | .inputs i => .var true (.inputs (i.castLe (by omega)))
    -- circuit of the outputs from 0..K, all ORd together, ignoring the new 'arity' output.
    let c0KAdapted : Circuit (Vars p.α arity (iter + 1)) := c0K.map fun v =>
       match v with
       | .state a => .state a
       | .inputs i => .inputs (i.castLe (by omega))
    let tStart ← IO.monoMsNow
    let tEnd ← IO.monoMsNow
    let tElapsedSec := (tEnd - tStart) / 1000
    logInfo s!"Built state circuit of size: '{c0KAdapted.size + cKSucc.size}' (time={tElapsedSec}s)"
    logInfo s!"Establishing inductive invariant with cadical..."
    let tStart ← IO.monoMsNow
    -- c = 0 => c' = 0
    -- !c => !c'
    -- !!c || !c'
    -- c || !c'
    -- c' => c
    let impliesCircuit : Circuit (Vars p.α arity (iter + 1)) := c0KAdapted ||| ~~~ cKSucc
    let safetyProperty := safetyProperty.map fun v =>
       match v with
       | .state a => .state a
       | .inputs i => .inputs (i.castLe (by omega))
    let safetyProperty := safetyProperty ||| impliesCircuit
    -- let formatαβarity : p.α ⊕ (β ⊕ arity) → Format := sorry
    logInfo m!"induction hyp circuit: {formatCircuit (Vars.format formatα formatArity) impliesCircuit}"
    -- let le : Bool := sorry
    let le ← checkCircuitTautoAux impliesCircuit
    let tEnd ← IO.monoMsNow
    let tElapsedSec := (tEnd - tStart) / 1000
    if le then
      logInfo s!"Inductive invariant established! (time={tElapsedSec}s)"
      return true
    else
      logInfo s!"Unable to establish inductive invariant (time={tElapsedSec}s). Recursing..."
      decideIfZerosAuxTermElabM (iter + 1) maxIter p (c0KAdapted ||| cKSucc) cKSucc safetyProperty

-- def decideIfZerosM {arity : Type _} [DecidableEq arity] [Monad m]
--     (decLe : {α : Type} → [DecidableEq α] → [Fintype α] → [Hashable α] →
--         (c : Circuit α) → (c' : Circuit α) → m { b : Bool // b ↔ c ≤ c' })
--     (p : FSM arity) : m Bool :=
--   decideIfZerosAuxM decLe p (p.nextBitCirc none).fst

@[nospecialize]
def _root_.FSM.decideIfZerosMCadical  {arity : Type _} [DecidableEq arity]  [Fintype arity] [Hashable arity]
   (fsm : FSM arity) (maxIter : Nat) : TermElabM Bool :=
  -- decideIfZerosM Circuit.impliesCadical fsm
  withTraceNode `bv_automata_circuit (fun _ => return "k-induction") (collapsed := true) do
    let c : Circuit (Vars fsm.α arity 0) := (fsm.nextBitCirc none).fst.map Vars.state
    let safety : Circuit (Vars fsm.α arity 0) := .fals
    decideIfZerosAuxTermElabM 0 maxIter fsm c c safety

end BvDecide


/--
Reflect an expression of the form:
  ∀ ⟦(w : Nat)⟧ (← focus)
  ∀ (b₁ b₂ ... bₙ : BitVec w),
  <proposition about bitvectors>.

Reflection code adapted from `elabNaticeDecideCoreUnsafe`,
which explains how to create the correct auxiliary definition of the form
`decideProprerty = true`, such that our goal state after using `ofReduceBool` becomes
⊢ ofReduceBool decideProperty = true

which is then indeed `rfl` equal to `true`.
-/
def reflectUniversalWidthBVs (g : MVarId) (cfg : Config) : TermElabM (List MVarId) := do
  let ws ← findExprBitwidths (← g.getType)
  let ws := ws.toArray
  if h0: ws.size = 0 then throwError "found no bitvector in the target: {indentD (← g.getType)}"
  else if hgt: ws.size > 1 then
    let (w1, wExample1) := ws[0]
    let (w2, wExample2) := ws[1]
    let mExample := f!"{w1} → {wExample1}" ++ f!"{w2} → {wExample2}"
    throwError "found multiple bitvector widths in the target: {indentD mExample}"
  else
    -- we have exactly one width
    let (w, wExample) := ws[0]

    -- We can now revert hypotheses that are of this bitwidth.
    let g ← revertBvHyps g

    -- Next, after reverting, we have a goal which we want to reflect.
    -- we convert this goal to NNF
    let .some g ← NNF.runNNFSimpSet g
      | logInfo m!"Converting to negation normal form automatically closed goal."
        return[]
    logInfo m!"goal after NNF: {indentD g}"

    let .some g ← Simplifications.runPreprocessing g
      | logInfo m!"Preprocessing automatically closed goal."
        return[]
    logInfo m!"goal after preprocessing: {indentD g}"

    -- finally, we perform reflection.
    let result ← reflectPredicateAux ∅ (← g.getType) w
    result.bvToIxMap.throwWarningIfUninterpretedExprs

    logInfo m!"predicate (repr): {indentD (repr result.e)}"

    let bvToIxMapVal ← result.bvToIxMap.toExpr w

    let target := (mkAppN (mkConst ``Predicate.denote) #[result.e.quote, w, bvToIxMapVal])
    let g ← g.replaceTargetDefEq target
    logInfo m!"goal after reflection: {indentD g}"

    -- Log the finite state machine size, and bail out if we cross the barrier.
    let fsm := predicateEvalEqFSM result.e |>.toFSM
    logInfo f!"{fsm.format}'"

    match cfg.backend with
    | .dryrun =>
        g.assign (← mkSorry (← g.getType) (synthetic := false))
        logInfo "Closing goal with 'sorry' for dry-run"
        return []
    | .cadical maxIter =>
      let isTrueForall ← fsm.decideIfZerosMCadical maxIter
      if isTrueForall
      then do
        let gs ← g.apply (mkConst ``Reflect.BvDecide.decideIfZerosMAx [])
        if gs.isEmpty
        then return gs
        else
          throwError "Expected application of 'decideIfZerosMAx' to close goal, but failed. {indentD g}"
      else
        throwError "failed to prove goal, since decideIfZerosM established that theorem is not true."
        return [g]
    | .lean =>
      if fsm.circuitSize > cfg.circuitSizeThreshold then
        throwError "Not running on goal: since circuit size ('{fsm.circuitSize}') is larger than threshold ('circuitSizeThreshold:{cfg.circuitSizeThreshold}')"
      if fsm.stateSpaceSize > cfg.stateSpaceSizeThreshold then
        throwError "Not running on goal: since state space size size ('{fsm.stateSpaceSize}') is larger than threshold ('stateSpaceSizeThreshold:{cfg.stateSpaceSizeThreshold}')"

      let (mapFv, g) ← generalizeMap g bvToIxMapVal;
      let (_, g) ← g.revert #[mapFv]
      -- Apply Predicate.denote_of_eval_eq.
      let wVal? ← Meta.getNatValue? w
      let g ←
        -- Fixed width problem
        if h : wVal?.isSome ∧ cfg.fastFixedWidth then
          logInfo m!"using special fixed-width procedure for fixed bitwidth '{w}'."
          let wVal := wVal?.get h.left
          let [g] ← g.apply <| (mkConst ``Predicate.denote_of_eval_eq_fixedWidth)
            | throwError m!"Failed to apply `Predicate.denote_of_eval_eq_fixedWidth` on goal '{indentD g}'"
          pure g
        else
          -- Generic width problem.
          -- If the generic width problem has as 'complex' width, then warn the user that they're
          -- trying to solve a fragment that's better expressed differently.
          if !w.isFVar then
            let msg := m!"Width '{w}' is not a free variable (i.e. width is not universally quantified)."
            let msg := msg ++ Format.line ++ m!"The tactic will perform width-generic reasoning."
            let msg := msg ++ Format.line ++ m!"To perform width-specific reasoning, rewrite goal with a width constraint, e.g. ∀ (w : Nat) (hw : w = {w}), ..."
            logWarning  msg

          let [g] ← g.apply <| (mkConst ``Predicate.denote_of_eval_eq)
            | throwError m!"Failed to apply `Predicate.denote_of_eval_eq` on goal '{indentD g}'"
          pure g
      let [g] ← g.apply <| (mkConst ``of_decide_eq_true)
        | throwError m!"Failed to apply `of_decide_eq_true on goal '{indentD g}'"
      let [g] ← g.apply <| (mkConst ``Lean.ofReduceBool)
        | throwError m!"Failed to apply `of_decide_eq_true on goal '{indentD g}'"
      return [g]

/-- Allow elaboration of `bv_automata_circuit's config` arguments to tactics. -/
declare_config_elab elabBvAutomataCircuitConfig Config

syntax (name := bvAutomataCircuit) "bv_automata_circuit" (Lean.Parser.Tactic.config)? : tactic
@[tactic bvAutomataCircuit]
def evalBvAutomataCircuit : Tactic := fun
| `(tactic| bv_automata_circuit $[$cfg]?) => do
  let cfg ← elabBvAutomataCircuitConfig (mkOptionalNode cfg)
  let g ← getMainGoal
  g.withContext do
    let gs ← reflectUniversalWidthBVs g cfg
    replaceMainGoal gs
    match gs  with
    | [] => return ()
    | [g] => do
      logInfo m!"goal being decided via boolean reflection: {indentD g}"
      evalDecideCore `bv_automata_circuit (cfg := { native := true : Parser.Tactic.DecideConfig })
    | _gs => throwError "expected single goal after reflecting, found multiple goals. quitting"
| _ => throwUnsupportedSyntax

end Reflect
