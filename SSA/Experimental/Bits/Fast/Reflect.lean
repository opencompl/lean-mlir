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
import SSA.Experimental.Bits.Frontend.Defs
import SSA.Experimental.Bits.Fast.BitStream
import SSA.Experimental.Bits.Fast.Defs
import SSA.Experimental.Bits.Fast.FiniteStateMachine
import SSA.Experimental.Bits.Fast.Decide
import SSA.Experimental.Bits.Frontend.Syntax
import SSA.Experimental.Bits.Frontend.Preprocessing
import Lean.Meta.ForEachExpr
import Lean.Meta.Tactic.Simp.BuiltinSimprocs.BitVec

import Lean

initialize Lean.registerTraceClass `Bits.Fast

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

theorem BitVec.add_getElem_zero {x y : BitVec w} (hw : 0 < w) : (x + y)[0] =
    ((x[0] ^^ y[0])) := by
  simp [hw, getElem_add hw]

theorem BitVec.add_getElem_succ (x y : BitVec w) (hw : i + 1 < w) : (x + y)[i + 1] =
    (x[i + 1] ^^ (y[i + 1]) ^^ carry (i + 1) x y false) := by
  simp [hw, getElem_add hw]

/-- TODO: simplify this proof, something too complex is going on here. -/
@[simp] theorem BitStream.toBitVec_add' (a b : BitStream) (w i : Nat) (hi : i < w) :
    ((a + b).toBitVec w).getLsbD i = ((a.toBitVec w) + (b.toBitVec w)).getLsbD i ∧
    (a.addAux b i).2 = (BitVec.carry (i + 1) (a.toBitVec w) (b.toBitVec w) false) := by
  simp [hi]
  rw [BitStream.add_eq_addAux]
  induction i
  case zero =>
    simp
    rw [BitVec.add_getElem_zero hi]
    simp [hi]
    simp [BitVec.carry_succ, hi]
  case succ i ih =>
    simp
    rw [BitVec.add_getElem_succ _ _ hi]
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
    case some x => simp [BitVec.signExtend_eq_setWidth_of_le]
  case zero => simp [eval, denote]
  case negOne => simp [eval, denote]; rw [← BitVec.neg_one_eq_allOnes]
  case one => simp [eval, denote]
  case ofNat n => simp [eval, denote]
  case and a b ha hb  => simp [eval, denote, ha, hb]
  case or a b ha hb => simp [eval, denote, ha, hb]
  case xor a b ha hb => simp [eval, denote, ha, hb]
  case not a ha => simp [eval, denote, ha]
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

private theorem BitVec.ForLean.ule_iff_ult_or_eq' (x y : BitVec w) : (x ≤ᵤ y) = (decide (x = y ∨ x < y)) := by
  simp only [· ≤ᵤ ·]
  by_cases hx : x = y ∨ x < y
  case pos => simp [hx]; bv_omega
  case neg => simp [hx]; bv_omega

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

theorem BitVec.ult_notation_eq_decide_ult (x y : BitVec w) : (x <ᵤ y) = decide (x < y) := by
  simp [BitVec.lt_def, BitVec.ult_toNat]
/--
The semantics of a predicate:
The predicate, when evaluated, at index `i` is false iff the denotation is true.
-/
theorem Predicate.eval_eq_denote (w : Nat) (p : Predicate) (vars : List (BitVec w)) :
    (p.eval (vars.map BitStream.ofBitVec) w = false) ↔ p.denote w vars := by
  induction p generalizing vars w
  case width wp n => cases wp <;> simp [eval, denote]
  case binary p a b =>
    cases p with
    | eq => simp [eval, denote]; apply evalEq_denote_false_iff
    | neq => simp [eval, denote]; apply evalNeq_denote
    | ult =>
      simp [eval, denote]
      rw [BitVec.ult_notation_eq_decide_ult]
      by_cases h: Term.denote w a vars < Term.denote w b vars
      case pos => simp only [h, decide_true, Bool.not_true]; rw [evalUlt_denote_false_iff]; exact h
      case neg => simp only [h, decide_false, Bool.not_false]; rw [evalUlt_denote_true_iff]; simpa using h
    | slt =>
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
    | ule =>
      simp [eval, denote];
      simp only [evalLor, BitStream.and_eq]
      rw [BitVec.ForLean.ule_iff_ult_or_eq' (Term.denote w a vars) (Term.denote w b vars)]
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
    | sle =>
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

-- /-- info: 'Predicate.eval_eq_denote' depends on axioms: [propext, Classical.choice, Quot.sound] -/
-- #guard_msgs in #print axioms Predicate.eval_eq_denote


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


/-
Armed with the above, we write a proof by reflection principle.
This is adapted from Bits/Fast/Tactic.lean, but is cleaned up to build 'nice' looking environments
for reflection, rather than ones based on hashing the 'fvar', which can also have weird corner cases due to hash collisions.

TODO(@bollu): For now, we don't reflects constants properly, since we don't have arbitrary constants in the term language (`Term`).
TODO(@bollu): We also assume that the goals are in negation normal form, and if we not, we bail out. We should make sure that we write a tactic called `nnf` that transforms goals to negation normal form.
-/

namespace Reflect
open Lean Meta Elab Tactic

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
  let ixs : Finset (Fin n) := Finset.univ
  let inputs : Finset ι := Finset.univ
  let out := ixs.biUnion
      (fun ix => inputs.map ⟨fun input => Inputs.mk ix input, by intros a b; simp⟩)
  ⟨out, by
    intros i
    obtain ⟨ix, input⟩ := i
    simp [out]
    constructor
    · apply Fintype.complete
    · apply Fintype.complete
  ⟩


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
    -- c0K k = 0 <-> ∀ i < k, p.eval env i = 0
    (c0K : Circuit (Vars p.α arity iter))
    -- cK k = 0 <-> ∀ p.eval env k = 0
    (cK : Circuit (Vars p.α arity iter))
    -- (safetyProperty K = 0) <->
    --   (∃ k < K,
    --      (∀ i < k, p.eval env i = 0) → p.eval env k = 0)
    (safetyProperty : Circuit (Vars p.α arity iter)) : TermElabM Bool := do
  trace[Bits.Fast] s!"### K-induction (iter {iter}) ###"
  if iter ≥ maxIter && maxIter != 0 then
    throwError s!"ran out of iterations, quitting"
    return false
  let cKWithInit : Circuit (Vars Empty arity iter) := cK.assignVars fun v _hv =>
    match v with
    | .state a => .inr (p.initCarry a) -- assign init state
    | .inputs is => .inl (.inputs is)
  let formatα : p.α → Format := fun s => "s" ++ formatDecEqFinset s
  let formatEmpty : Empty → Format := fun e => e.elim
  let formatArity : arity → Format := fun i => "i" ++ formatDecEqFinset i
  trace[Bits.Fast] m!"safety property circuit: {formatCircuit (Vars.format formatEmpty formatArity) cKWithInit}"
  if ← checkCircuitSatAux cKWithInit
  then
    trace[Bits.Fast] s!"Safety property failed on initial state."
    return false
  else
    trace[Bits.Fast] s!"Safety property succeeded on initial state. Building next state circuit..."
    -- circuit of the output at state (k+1)
    trace[Bits.Fast] m!"cK: {formatCircuit (Vars.format formatα formatArity) cK}"
    let cKSucc : Circuit (Vars p.α arity (iter + 1)) :=
      cK.bind fun v =>
        match v with
        | .state a => p.nextBitCirc (some a) |>.map fun v =>
          match v with
          | .inl a => .state a
          | .inr x => .inputs <| Inputs.latest x
        | .inputs i => .var true (.inputs (i.castLe (by omega)))
    trace[Bits.Fast] m!"cKSucc: {formatCircuit (Vars.format formatα formatArity) cKSucc}"
    -- circuit of the outputs from 0..K, all ORd together, ignoring the new 'arity' output.
    trace[Bits.Fast] m!"c0K: {formatCircuit (Vars.format formatα formatArity) c0K}"
    let c0KAdapted : Circuit (Vars p.α arity (iter + 1)) := c0K.map fun v =>
       match v with
       | .state a => .state a
       | .inputs i => .inputs (i.castLe (by omega))
    trace[Bits.Fast] m!"c0KAdapted: {formatCircuit (Vars.format formatα formatArity) c0K}"
    let tStart ← IO.monoMsNow
    let tEnd ← IO.monoMsNow
    let tElapsedSec := (tEnd - tStart) / 1000
    trace[Bits.Fast] s!"Built state circuit of size: '{c0KAdapted.size + cKSucc.size}' (time={tElapsedSec}s)"
    trace[Bits.Fast] s!"Establishing inductive invariant with cadical..."
    let tStart ← IO.monoMsNow
    -- [(c = 0 => c' = 0)] <-> [(!c => !c') = 1]
    -- [(!!c || !c')= 1]
    -- [(c || !c') = 1] ← { this is the formula we use }
    let impliesCircuit : Circuit (Vars p.α arity (iter + 1)) := c0KAdapted ||| ~~~ cKSucc
    let safetyProperty := safetyProperty.map fun v =>
       match v with
       | .state a => .state a
       | .inputs i => .inputs (i.castLe (by omega))
    let safetyProperty := safetyProperty ||| impliesCircuit
    -- let formatαβarity : p.α ⊕ (β ⊕ arity) → Format := sorry
    trace[Bits.Fast] m!"induction hyp circuit: {formatCircuit (Vars.format formatα formatArity) impliesCircuit}"
    -- let le : Bool := sorry
    let le ← checkCircuitTautoAux safetyProperty
    let tEnd ← IO.monoMsNow
    let tElapsedSec := (tEnd - tStart) / 1000
    if le then
      trace[Bits.Fast] s!"Inductive invariant established! (time={tElapsedSec}s)"
      return true
    else
      trace[Bits.Fast] s!"Unable to establish inductive invariant (time={tElapsedSec}s). Recursing..."
      decideIfZerosAuxTermElabM (iter + 1) maxIter p (c0KAdapted ||| cKSucc) cKSucc safetyProperty


@[nospecialize]
def _root_.FSM.decideIfZerosMCadical  {arity : Type _} [DecidableEq arity]  [Fintype arity] [Hashable arity]
   (fsm : FSM arity) (maxIter : Nat) : TermElabM Bool :=
  -- decideIfZerosM Circuit.impliesCadical fsm
  withTraceNode `Bits.Fast (fun _ => return "k-induction") (collapsed := false) do
    let c : Circuit (Vars fsm.α arity 0) := (fsm.nextBitCirc none).fst.map Vars.state
    let safety : Circuit (Vars fsm.α arity 0) := .fals
    decideIfZerosAuxTermElabM 0 maxIter fsm c c safety

end BvDecide

end Reflect
