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
open Std Sat AIG

/--
Convert a 'Circuit α' into an 'AIG α' in order to reuse bv_decide's
bitblasting capabilities.
-/
@[nospecialize]
def _root_.Circuit.toAIGAux [DecidableEq α] [Fintype α] [Hashable α] (c : Circuit α) (aig : AIG α) :
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
    let ⟨⟨aig, lhsRef⟩, lextend⟩ := l.toAIGAux aig
    let ⟨⟨aig, rhsRef⟩, rextend⟩ := r.toAIGAux aig
    let lhsRef := lhsRef.cast <| by
      dsimp only at rextend ⊢
      omega
    let input := ⟨lhsRef, rhsRef⟩
    let ret := aig.mkAndCached input
    have Lawful := LawfulOperator.le_size (f := mkAndCached) aig input
    ⟨ret, by dsimp only [ret] at lextend rextend ⊢; omega⟩
  | .or l r =>
    let ⟨⟨aig, lhsRef⟩, lextend⟩ := l.toAIGAux aig
    let ⟨⟨aig, rhsRef⟩, rextend⟩ := r.toAIGAux aig
    let lhsRef := lhsRef.cast <| by
      dsimp only at rextend ⊢
      omega
    let input := ⟨lhsRef, rhsRef⟩
    let ret := aig.mkOrCached input
    have Lawful := LawfulOperator.le_size (f := mkOrCached) aig input
    ⟨ret, by dsimp only [ret] at lextend rextend ⊢; omega⟩
  | .xor l r =>
    let ⟨⟨aig, lhsRef⟩, lextend⟩ := l.toAIGAux aig
    let ⟨⟨aig, rhsRef⟩, rextend⟩ := r.toAIGAux aig
    let lhsRef := lhsRef.cast <| by
      dsimp only at rextend ⊢
      omega
    let input := ⟨lhsRef, rhsRef⟩
    let ret := aig.mkXorCached input
    have Lawful := LawfulOperator.le_size (f := mkXorCached) aig input
    ⟨ret, by dsimp only [ret] at lextend rextend ⊢; omega⟩

def _root_.Circuit.toAIG [DecidableEq α] [Fintype α] [Hashable α]
    (c : Circuit α) : Entrypoint α :=
  (c.toAIGAux .empty).val

/- Proof: Structural recursion on the circuit. -/
@[simp]
theorem _root_.Circuit.denote_toAIG_eq_eval [DecidableEq α] [Fintype α] [Hashable α]
    {c : Circuit α}
    {env : α → Bool} :
    Std.Sat.AIG.denote env c.toAIG = c.eval env := by sorry

open Std Sat AIG Reflect in
def verifyAIG [DecidableEq α ] [Hashable α] (x : Entrypoint α) (cert : String) : Bool :=
  let y := (Entrypoint.relabelNat x)
  let z := AIG.toCNF y
  Std.Tactic.BVDecide.Reflect.verifyCert z cert

def verifyCert [DecidableEq α] [Fintype α] [Hashable α] (c : Circuit α) (cert : String) : Bool :=
  verifyAIG c.toAIG cert

/- Proof: adapt 'Std.Tactic.BVDecide.Reflect.unsat_of_verifyBVExpr_eq_true' -/
theorem always_false_of_cerifyAIG [DecidableEq α] [Fintype α] [Hashable α]
    (c : Circuit α) (cert : String)
    (h : verifyAIG c.toAIG cert) :
    c.always_false := by sorry

/-!
Helpers to use `bv_decide` as a solver-in-the-loop for the reflection proof.
-/

def cadicalTimeoutSec : Nat := 1000

attribute [nospecialize] Circuit.toAIG
-- attribute [nospecialize] Std.Sat.AIG.Entrypoint.relabelNat'

open Std Sat AIG Tactic BVDecide Frontend in
@[nospecialize]
def checkCircuitUnsatAux [DecidableEq α] [Hashable α] [Fintype α] (c : Circuit α) : TermElabM (Option LratCert) := do
  let cfg : BVDecideConfig := { timeout := cadicalTimeoutSec }
  IO.FS.withTempFile fun _ lratFile => do
    let cfg ← BVDecide.Frontend.TacticContext.new lratFile cfg
    let entrypoint:= c.toAIG
    let ⟨entrypoint, _labelling⟩ := entrypoint.relabelNat'
    let cnf := toCNF entrypoint
    let out ← runExternal cnf cfg.solver cfg.lratPath
      (trimProofs := true)
      (timeout := cadicalTimeoutSec)
      (binaryProofs := true)
    match out with
    | .error _model => return .none
    | .ok cert => return .some cert


open Std Sat AIG Tactic BVDecide Frontend in
@[nospecialize]
def checkCircuitTautoAuxImpl
    [DecidableEq α] [Hashable α] [Fintype α]
    (c : Circuit α) : TermElabM (Option LratCert) := do
  let cfg : BVDecideConfig := { timeout := cadicalTimeoutSec }
  IO.FS.withTempFile fun _ lratFile => do
    let cfg ← BVDecide.Frontend.TacticContext.new lratFile cfg
    let c := ~~~ c -- we're checking TAUTO, so check that negation is UNSAT.
    let entrypoint := c.toAIG
    let ⟨entrypoint, _labelling⟩ := entrypoint.relabelNat'
    let cnf := toCNF entrypoint
    let out ← runExternal cnf cfg.solver cfg.lratPath
      (trimProofs := true)
      (timeout := cadicalTimeoutSec)
      (binaryProofs := true)
    match out with
    | .error _model => return none
    | .ok cert => return some cert

open Std Sat AIG Tactic BVDecide Frontend in
@[implemented_by checkCircuitTautoAuxImpl, nospecialize]
def checkCircuitTautoAux {α : Type}
    [DecidableEq α] [Hashable α] [Fintype α]
    (c : Circuit α) : TermElabM (Option LratCert) := do
  return none

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

def elim0 {α : Sort u} (i : Inputs ι 0) : α :=
  i.ix.elim0

def latest (i : ι) : Inputs ι (n+1) where
  ix := ⟨n, by omega⟩
  input := i

def castLe (i : Inputs ι n) (hn : n ≤ m) : Inputs ι m where
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

def Vars.castLe {n m : Nat} (v : Vars σ ι n) (hnm : n ≤ m) : Vars σ ι m :=
  match v with
  | .state s => .state s
  | .inputs is => .inputs (is.castLe hnm)

/-- Relate boolean and bitstream environments. -/
structure EnvOutRelated {arity : Type _} {α : Type _}
    (envBool : Vars α arity n → Bool)
    (envBitstream : arity → BitStream) where
  envBool_eq_envBitstream : ∀ (x : arity) (i : Nat) (hi: i < n),
    envBool (Vars.inputs (Inputs.mk ⟨i, by omega⟩ x)) = envBitstream x i

attribute [simp] EnvOutRelated.envBool_eq_envBitstream

def envBool_of_envBitStream
   (envBitstream : arity → BitStream)
   (n : Nat) : Vars Empty arity (n + 1) → Bool :=
  fun x =>
    match x with
    | .state s => s.elim
    | .inputs (.mk a i) => envBitstream i a

/-- make the init carry of the FSM from the envBool. -/
def initCarry_of_envBool {p : FSM α}
  (envBool : Vars p.α arity n → Bool) :
  p.α → Bool := fun a => envBool (.state a)

@[simp]
theorem EnvOutRelated_envBool_of_envBitStream_of_self {arity : Type _}
    (envBitstream : arity → BitStream) :
    EnvOutRelated (envBool_of_envBitStream envBitstream n) envBitstream := by
  constructor
  intros x i hi
  rw [envBool_of_envBitStream]


structure StateCircuit {arity : Type _}
    [DecidableEq arity]
    [Fintype arity]
    [Hashable arity]
    (p : FSM arity) (iter : Nat) where ofFun ::
  toFun : p.α →  Circuit (Vars p.α arity iter)

/-- Product initial state vector,
that sets the state to be the intial state as given by the FSM.. -/
def StateCircuit.zero {arity : Type _}
    [DecidableEq arity]
    [Fintype arity]
    [Hashable arity]
    (p : FSM arity) : StateCircuit p 0 where
  toFun :=
    fun a => Circuit.ofBool (p.initCarry a)

@[simp]
theorem StateCircuit.zero_eval {arity : Type _}
    [DecidableEq arity]
    [Fintype arity]
    [Hashable arity]
    {p : FSM arity} {a : p.α} (envBool : Vars p.α arity 0 → Bool) :
    ((StateCircuit.zero p).toFun a).eval envBool = p.initCarry a := by
  simp only [zero, Circuit.ofBool]
  rcases h : p.initCarry a <;> simp [h]

/-- Product free state vector, that reads state from the input.. -/
def StateCircuit.id  {arity : Type _}
    [DecidableEq arity]
    [Fintype arity]
    [Hashable arity]
    (p : FSM arity) : StateCircuit p 0 where
  toFun :=
    fun a => Circuit.var true (Vars.state a)

@[simp]
theorem StateCircuit.id_eval {arity : Type _}
    [DecidableEq arity]
    [Fintype arity]
    [Hashable arity]
    {p : FSM arity} {a : p.α} {envBool : Vars p.α arity 0 → Bool} :
    ((StateCircuit.id p).toFun a).eval envBool = (envBool (Vars.state a)) := by
  simp only [id, Circuit.ofBool]
  rcases h : p.initCarry a <;> simp [h]

/-- Make a circuit for one step of transition.  -/
def StateCircuit.delta  {arity : Type _}
    [DecidableEq arity]
    [Fintype arity]
    [Hashable arity]
    (p : FSM arity) : StateCircuit p 1 where
  toFun :=
    fun a =>
      let x := StateCircuit.id p
      x.toFun a |>.bind fun v =>
        match v with
        | .state s =>
          let d := p.nextBitCirc (some s)
          d.map fun w =>
            match w with
            | .inl a => Vars.state a
            | .inr i => Vars.inputs (Inputs.mk 0 i)
        | .inputs i => i.elim0

@[simp]
theorem StateCircuit.delta_eval {arity : Type _}
    [DecidableEq arity]
    [Fintype arity]
    [Hashable arity]
    {p : FSM arity} {a : p.α} (envBool : Vars p.α arity 1 → Bool)
    (envBitstream : arity → BitStream)
    (hEnvBitstream : EnvOutRelated envBool envBitstream)
    :
    ((StateCircuit.delta p).toFun a).eval envBool =
     p.evalWith (initCarry_of_envBool envBool) envBitstream 1 := by
  simp [delta, Circuit.eval_bind, Circuit.eval_map]
  sorry

/-- Allow state circuit to consume more inputs.  -/
def StateCircuit.castLe  {arity : Type _}
    [DecidableEq arity]
    [Fintype arity]
    [Hashable arity]
    {p : FSM arity}
    (cn : StateCircuit p n)
    (hnm : n ≤ m) :  StateCircuit p m where
  toFun := fun state =>
    (cn.toFun state).map fun v => v.castLe hnm

/-- Move inputs from [0..n) to [d..d+n). -/
def StateCircuit.translateInputs {arity : Type _}
    [DecidableEq arity]
    [Fintype arity]
    [Hashable arity]
    {p : FSM arity}
    (cn : StateCircuit p n)
    (d : Nat) : StateCircuit p (d + n) where
  toFun := fun state =>
    (cn.toFun state).map fun v =>
      match v with
      | .state s => .state s
      | .inputs i => .inputs (Inputs.mk ⟨i.ix + d, by omega⟩ i.input)


/-- Compose state circuits of 'n' steps and 'm' steps to get a circuit for 'n + m' steps. -/
def StateCircuit.compose {arity : Type _}
    [DecidableEq arity]
    [Fintype arity]
    [Hashable arity]
    {p : FSM arity}
    /- Circuit that runs for [0..n) steps. -/
    (sFst : StateCircuit p n)
    /- Circuit that runs for [n..n+m ] steps. -/
    (sSnd : StateCircuit p m) :
    StateCircuit p (n + m) where
  toFun := fun state =>
    ((sSnd.translateInputs n).toFun state).bind fun v =>
      match v with
      | .state s =>
          (sFst.castLe (show n ≤ n + m by omega)).toFun s
      | .inputs i => Circuit.var .false (.inputs i)

/-- How to evaluate composition of circuits. -/
theorem StateCircuit.eval_compose {arity : Type _}
    [DecidableEq arity]
    [Fintype arity]
    [Hashable arity]
    {p : FSM arity} {a : p.α} (envBool : Vars p.α arity (n + m) → Bool)
    (envBitstream : arity → BitStream)
    (sFst : StateCircuit p n) (sSnd : StateCircuit p m)
    (hEnvBitstream : EnvOutRelated envBool envBitstream)
    :
    ((StateCircuit.compose sFst sSnd).toFun a).eval envBool =
      (sSnd.toFun a).eval (fun v =>
        match v with
        | .state s => (sFst.toFun s).eval (fun v => envBool (v.castLe (by omega)))
        | .inputs i => envBool <| .inputs <| i.castLe (by omega)
      ):= by
  sorry

/-- Build the output circuit from the given state circuit. -/
def StateCircuit.toOutput {arity : Type _}
    [DecidableEq arity]
    [Fintype arity]
    [Hashable arity]
    {p : FSM arity}
    /- Circuit that runs for [0..n) steps. -/
    (sc : StateCircuit p n)
    /- Circuit that runs for [0..n+1] steps and produces an output. -/
    : Circuit (Vars p.α arity (n + 1)) :=
  (p.nextBitCirc none).bind fun v =>
    match v with
    | .inl s => (sc.castLe (by omega)).toFun s
    | .inr i =>  Circuit.var true (Vars.inputs (Inputs.mk ⟨n, by omega⟩ i))


/-- Build the circuit for n transitions.-/
def StateCircuit.deltaN  {arity : Type _}
    [DecidableEq arity]
    [Fintype arity]
    [Hashable arity]
    (p : FSM arity)
    (n : Nat) : StateCircuit p n :=
  match n with
  | 0 => StateCircuit.id p
  | n' + 1 =>
    let d := (StateCircuit.delta p)
    let sn := StateCircuit.deltaN p n'
    sn.compose d


/-- Make circuit that produces output for index 'i'. -/
def StateCircuit.deltaNOutput {arity : Type _}
  [DecidableEq arity]
  [Fintype arity]
  [Hashable arity]
  (p : FSM arity) (n : Nat) (i : Nat)  (hin : i ≤ n): (Circuit (Vars p.α arity (n+1))) :=
  ((StateCircuit.deltaN p i).castLe (show i ≤ n by omega)).toOutput


@[simp]
theorem StateCircuit.eval_deltaNOutput_eq
    {arity : Type _}
    [DecidableEq arity]
    [Fintype arity]
    [Hashable arity]
    (p : FSM arity) (n : Nat) (i : Nat) (hin : i ≤ n)
    (envBool : Vars p.α arity (n + 1) → Bool)
    (envBitstream : arity → BitStream)
    (envInit : p.α → Bool)
    (hEnvInit : envInit = initCarry_of_envBool envBool)
    (hEnvBitstream : EnvOutRelated envBool envBitstream)
    :
    (deltaNOutput p n i hin).eval envBool = p.evalWith envInit envBitstream i := by
  sorry


/-- Take the 'or' of many circuits.-/
def Circuit.bigOr {α : Type _}
    (cs : List (Circuit α)) : Circuit α :=
  match cs with
  | [] => Circuit.fals
  | c :: cs =>
    c.or (Circuit.bigOr cs)

@[simp]
theorem Circuit.eval_bigOr_eq_false_iff
    (cs : List (Circuit α)) (env : α → Bool):
    (Circuit.bigOr cs).eval env = false ↔
    (∀ (c : Circuit α), c ∈ cs → c.eval env = false) := by
  induction cs
  case nil => simp [bigOr]
  case cons a as ih =>
    simp [bigOr, ih]

@[simp]
theorem Circuit.eval_bigOr_eq_true_iff
    (cs : List (Circuit α)) (env : α → Bool):
    (Circuit.bigOr cs).eval env = true ↔
    (∃ (c : Circuit α), c ∈ cs ∧ c.eval env = true) := by
  induction cs
  case nil => simp [bigOr]
  case cons a as ih =>
    simp [bigOr, ih]

/-- Take the and of many circuits.-/
def Circuit.bigAnd {α : Type _}
    (cs : List (Circuit α)) : Circuit α :=
  match cs with
  | [] => Circuit.tru
  | c :: cs =>
    c.and (Circuit.bigAnd cs)

@[simp]
theorem Circuit.eval_bigAnd_eq_true_iff
    (cs : List (Circuit α)) (env : α → Bool):
    (Circuit.bigAnd cs).eval env = true ↔
    (∀ (c : Circuit α), c ∈ cs → c.eval env = true) := by
  induction cs
  case nil => simp [bigAnd]
  case cons a as ih =>
    simp [bigAnd, ih]

@[simp]
theorem Circuit.eval_bigAnd_eq_false_iff
    (cs : List (Circuit α)) (env : α → Bool):
    (Circuit.bigAnd cs).eval env = false ↔
    (∃ (c : Circuit α), c ∈ cs ∧ c.eval env = false) := by
  induction cs
  case nil => simp [bigAnd]
  case cons a as ih =>
    simp only [bigAnd, Circuit.eval.eq_4, Bool.and_eq_false_imp, ih, List.mem_cons,
      exists_eq_or_imp]
    by_cases h : a.eval env <;> simp [h]

/--
Make the safety circuit at index 'i',
which runs the program at the initial state on the inputs.
See that this fixes the state to 'Empty'.
-/
def mkSafetyCircuitAuxElem {arity : Type _}
  [DecidableEq arity]
  [Fintype arity]
  [Hashable arity]
  (p : FSM arity) (n : Nat) (i : Nat) (hin : i ≤ n) : (Circuit (Vars Empty arity (n+1))) :=
  (StateCircuit.deltaNOutput p n i (by omega)).bind fun v =>
    match v with
    | .state s => Circuit.ofBool <| p.initCarry s
    | .inputs i => Circuit.var true (.inputs i)


@[simp]
theorem eval_mkSafetyCircuitAuxElem_eq_false_iff
    {arity : Type _}
    [DecidableEq arity]
    [Fintype arity]
    [Hashable arity]
    (p : FSM arity) (n : Nat) (i : Nat) (hin : i ≤ n)
    (envBool : Vars Empty arity (n + 1) → Bool)
    (envBitstream : arity → BitStream)
    (hEnvBitstream : EnvOutRelated envBool envBitstream) :
    (mkSafetyCircuitAuxElem p n i hin).eval envBool = false ↔
    p.eval envBitstream i = false := by
  simp [mkSafetyCircuitAuxElem]
  simp [Circuit.eval_bind]
  rw [StateCircuit.eval_deltaNOutput_eq (envInit := p.initCarry) (envBitstream := envBitstream)]
  · simp
  · -- TODO: extract out theorems here.
    ext i
    simp [initCarry_of_envBool]
    rcases h : (p.initCarry i) <;> simp [h]
  ·  -- TODO: extract out theorems here.
    constructor
    simp
    apply hEnvBitstream.envBool_eq_envBitstream

/-- Make the list of safety circuits upto length 'n + 1'. -/
def mkSafetyCircuitAuxList {arity : Type _}
  [DecidableEq arity]
  [Fintype arity]
  [Hashable arity]
  (p : FSM arity) (n : Nat) :
  List (Circuit (Vars Empty arity (n+1))) :=
  (List.range n).attach.map (fun i =>
    mkSafetyCircuitAuxElem p n i.val (by
      have := i.prop;
      simp at this
      omega))

/--
make the circuit that witnesses safety for (n+1) steps.
This builds the safety circuit for 'n+1' steps, and takes the 'or' of all of these.
-/
def mkSafetyCircuit {arity : Type _}
  [DecidableEq arity] [Fintype arity] [Hashable arity]
  (p : FSM arity) (n : Nat) : Circuit (Vars Empty arity (n+1)) :=
  Circuit.bigOr (mkSafetyCircuitAuxList p n)

/--
Evaluating the safety circuit is false iff
the bitstreams are false upto index 'n'.
-/
@[simp]
theorem eval_mkSafetyCircuit_eq_false_iff {arity : Type _}
    [DecidableEq arity] [Fintype arity] [Hashable arity]
    (p : FSM arity) (n : Nat)
    (envBool : Vars Empty arity (n + 1) → Bool)
    (envBitstream : arity → BitStream)
    (hEnvBitstream : EnvOutRelated envBool envBitstream) :
    (mkSafetyCircuit p n).eval envBool = false ↔
    (∀ (i : Nat), i < n → p.eval envBitstream i = false) := by
  rw [mkSafetyCircuit]
  rw [Circuit.eval_bigOr_eq_false_iff]
  rw [mkSafetyCircuitAuxList]
  simp
  constructor
  · intros hc i hi
    specialize hc _ i hi rfl
    rw [eval_mkSafetyCircuitAuxElem_eq_false_iff
      (envBitstream := envBitstream)
      (hEnvBitstream := hEnvBitstream)
    ] at hc
    apply hc
  · intros heval circ i hi hCirc
    subst hCirc
    rw [eval_mkSafetyCircuitAuxElem_eq_false_iff (hEnvBitstream := hEnvBitstream)]
    apply heval
    omega

/-- LHS of the inductive hypothesis circuit, which is a list of transitions. -/
def mkIndHypAuxElemLhsList  {arity : Type _}
    [DecidableEq arity] [Fintype arity] [Hashable arity]
    (p : FSM arity) (n : Nat) (i : Nat) (hin : i ≤ n) :
    List (Circuit (Vars p.α arity (n+1))) :=
  (List.range i).attach.map (fun i =>
    StateCircuit.deltaNOutput p n i.val (by
      have := i.prop;
      simp at this
      omega))

/-- The ⋁ of the inductive hypothesis LHS elements, which is the LHS of the indhyp. -/
def mkIndHypAuxElemLhs {arity : Type _}
    [DecidableEq arity] [Fintype arity] [Hashable arity]
    (p : FSM arity) (n : Nat) (i : Nat) (hin : i ≤ n) :
    Circuit (Vars p.α arity (n+1)) :=
  Circuit.bigOr <| mkIndHypAuxElemLhsList p n i hin

/-- The RHS of the indhyp, which states that the state at i + 1 is safe. -/
def mkIndHypAuxElemRhs {arity : Type _}
    [DecidableEq arity] [Fintype arity] [Hashable arity]
    (p : FSM arity) (n : Nat) (i : Nat) (hin : i ≤ n) :
    Circuit (Vars p.α arity (n+1)) :=
  StateCircuit.deltaNOutput p n i (by omega)

/-- Make the inductive hypothesis circuit at index 'i'. -/
def mkIndHypAuxElem {arity : Type _}
  [DecidableEq arity] [Fintype arity] [Hashable arity]
  (p : FSM arity) (n : Nat) (i : Nat) (hin : i ≤ n) :
  Circuit (Vars p.α arity (n+1)) :=
  /- Safe upto state n implies safe at state n. -/
  (~~~ ((~~~ mkIndHypAuxElemLhs p n i hin)).implies
    (~~~ (mkIndHypAuxElemRhs p n (i+1) (by sorry))))

/-- The induction hypothesis circuit is false, iff
the invariant holding upto i implies it holds at 'i+1'.
-/
@[simp]
theorem eval_mkIndHypAuxElem_eq_false_iff {arity : Type _}
    [DecidableEq arity] [Fintype arity] [Hashable arity]
    (p : FSM arity) (n : Nat) (i : Nat) (hin : i ≤ n)
    (envBool : Vars p.α arity (n + 1) → Bool)
    (envBitstream : arity → BitStream) :
    (Circuit.eval (mkIndHypAuxElem p n i hin) envBool = false) ↔
    ((∀ (j : Nat), (j < i) → p.evalWith (initCarry_of_envBool envBool) envBitstream j = false) →
     p.evalWith (initCarry_of_envBool envBool) envBitstream (i + 1) = false) := by
  sorry

/-- Make the inductive hypothesis circuit. -/
def mkIndHypAuxList {arity : Type _}
  [DecidableEq arity]
  [Fintype arity]
  [Hashable arity]
  (p : FSM arity) (n : Nat) (i : Nat) (hin : i ≤ n) :
  List (Circuit (Vars p.α arity (n+1))) :=
  (List.range n).attach.map (fun i =>
    mkIndHypAuxElem p n i.val (by
      have := i.prop;
      simp at this
      omega))

def mkIndHypCircuit {arity : Type _}
  [DecidableEq arity]
  [Fintype arity]
  [Hashable arity]
  (p : FSM arity) (n : Nat) : Circuit (Vars p.α arity (n+1)) :=
  Circuit.bigAnd (mkIndHypAuxList p n n (by omega))

@[simp]
theorem eval_mkIndHypCircuit_eq_false_iff
    {arity : Type _}
    [DecidableEq arity]
    [Fintype arity]
    [Hashable arity]
    (p : FSM arity) (n : Nat)
    (envBool : Vars p.α arity (n + 1) → Bool)
    (envBitstream : arity → BitStream) :
    (mkIndHypCircuit p n).eval envBool = false ↔
    (∀ (i : Nat), i < n → p.eval envBitstream i = false →
      p.eval envBitstream (i + 1) = false) := by
  rw [mkIndHypCircuit]
  rw [Circuit.eval_bigAnd_eq_false_iff]
  simp [mkIndHypAuxList]
  sorry

/- Key theorem that we want: if this is false, then the circuit always produces zeroes. -/
theorem eval_eq_false_of_mkIndHypCircuit_false_of_mkSafetyCircuit_false
    {arity : Type _}
    [DecidableEq arity]
    [Fintype arity]
    [Hashable arity]
    (p : FSM arity)
    (hs : (mkSafetyCircuit p n).always_false)
    (hind : (mkIndHypCircuit p n).always_false) :
    ∀ env i, p.eval env i = false := by
  simp at hs hind
  intros env i
  sorry

/-- Version that is better suited to proving. -/
theorem eval_eq_false_of_verifyCert_mkSafetyCircuit_verifyCert_mk
    {arity : Type _}
    [DecidableEq arity]
    [Fintype arity]
    [Hashable arity]
    (p : FSM arity)
    (sCert : BVDecide.Frontend.LratCert)
    (hs : verifyAIG (mkSafetyCircuit p n).toAIG sCert = true)
    (indCert : BVDecide.Frontend.LratCert)
    (hind : verifyAIG (mkIndHypCircuit p n).toAIG indCert = true) :
    ∀ env i, p.eval env i = false := by
  apply eval_eq_false_of_mkIndHypCircuit_false_of_mkSafetyCircuit_false (n := n)
  · apply always_false_of_cerifyAIG
    exact hs
  · apply always_false_of_cerifyAIG
    exact hind

inductive DecideIfZerosOutput
/-- Safety property fails at this iteration. -/
| safetyFailure (iter : Nat)
/-- Was unable to establish invariant even at these many iterations. -/
| exhaustedIterations (numIters : Nat)
/-- we have proven both the safety and inductive invariant property. -/
| proven (numIters : Nat) (safetyCert : BVDecide.Frontend.LratCert) (indCert : BVDecide.Frontend.LratCert)

namespace DecideIfZerosOutput
def isSuccess : DecideIfZerosOutput → Bool
  | .safetyFailure _ => false
  | .exhaustedIterations _ => false
  | .proven .. => true
end DecideIfZerosOutput

/-
@[nospecialize]
partial def decideIfZerosAuxTermElabMOld {arity : Type _}
    [DecidableEq arity] [Fintype arity] [Hashable arity]
    (iter : Nat) (maxIter : Nat)
    (p : FSM arity)
    (c0K : Circuit (Vars p.α arity iter))
    (cK : Circuit (Vars p.α arity iter))
    (safetyProperty : Circuit (Vars p.α arity iter)) :
    TermElabM (DecideIfZerosOutput) := do
  trace[Bits.Fast] s!"## K-induction (iter {iter})"
  if iter ≥ maxIter && maxIter != 0 then
    throwError s!"ran out of iterations, quitting"
    return .exhaustedIterations maxIter
  let cKWithInit : Circuit (Vars Empty arity iter) := cK.assignVars fun v _hv =>
    match v with
    | .state a => .inr (p.initCarry a) -- assign init state
    | .inputs is => .inl (.inputs is)
  let formatα : p.α → Format := fun s => "s" ++ formatDecEqFinset s
  let formatEmpty : Empty → Format := fun e => e.elim
  let formatArity : arity → Format := fun i => "i" ++ formatDecEqFinset i
  trace[Bits.Fast] m!"safety property circuit: {formatCircuit (Vars.format formatEmpty formatArity) cKWithInit}"
  match ← checkCircuitUnsatAux cKWithInit with
  | .none =>
    trace[Bits.Fast] s!"Safety property failed on initial state."
    return .safetyFailure iter
  | .some safetyCert =>
    trace[Bits.Fast] s!"Safety property succeeded on initial state. Building next state circuit..."
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
    trace[Bits.Fast] s!"Built state circuit of size: '{c0KAdapted.size + cKSucc.size}' (time={tElapsedSec}s)"
    trace[Bits.Fast] s!"Establishing inductive invariant with cadical..."
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
    trace[Bits.Fast] m!"induction hyp circuit: {formatCircuit (Vars.format formatα formatArity) impliesCircuit}"
    -- let le : Bool := sorry
    let tautoCert? ← checkCircuitTautoAux safetyProperty
    let tEnd ← IO.monoMsNow
    let tElapsedSec := (tEnd - tStart) / 1000
    match tautoCert? with
    | .some tautoCert =>
      trace[Bits.Fast] s!"Inductive invariant established! (time={tElapsedSec}s)"
      return .proven iter safetyCert tautoCert
    | .none =>
      trace[Bits.Fast] s!"Unable to establish inductive invariant (time={tElapsedSec}s). Recursing..."
      decideIfZerosAuxTermElabMOld (iter + 1) maxIter p (c0KAdapted ||| cKSucc) cKSucc safetyProperty

@[nospecialize]
def _root_.FSM.decideIfZerosMCadicalOld  {arity : Type _} [DecidableEq arity]  [Fintype arity] [Hashable arity]
   (fsm : FSM arity) (maxIter : Nat) : TermElabM DecideIfZerosOutput :=
  -- decideIfZerosM Circuit.impliesCadical fsm
  withTraceNode `Bits.Fast (fun _ => return "k-induction") (collapsed := true) do
    let c : Circuit (Vars fsm.α arity 0) := (fsm.nextBitCirc none).fst.map Vars.state
    let safety : Circuit (Vars fsm.α arity 0) := .fals
    decideIfZerosAuxTermElabMOld 0 maxIter fsm c c safety
-/


@[nospecialize]
partial def decideIfZerosAuxTermElabMNew {arity : Type _}
    [DecidableEq arity] [Fintype arity] [Hashable arity]
    (iter : Nat) (maxIter : Nat)
    (p : FSM arity) :
    TermElabM (DecideIfZerosOutput) := do
  trace[Bits.Fast] s!"K-induction (iter={iter})"
  if iter ≥ maxIter && maxIter != 0 then
    throwError s!"ran out of iterations, quitting"
    return .exhaustedIterations maxIter
  let tStart ← IO.monoMsNow
  let cSafety : Circuit (Vars Empty arity (iter+1)) := mkSafetyCircuit p iter
  let tEnd ← IO.monoMsNow
  let tElapsedSec := (tEnd - tStart) / 1000
  trace[Bits.Fast] m!"Built safety circuit in '{tElapsedSec}s'"

  let formatα : p.α → Format := fun s => "s" ++ formatDecEqFinset s
  let formatEmpty : Empty → Format := fun e => e.elim
  let formatArity : arity → Format := fun i => "i" ++ formatDecEqFinset i
  trace[Bits.Fast] m!"safety circuit: {formatCircuit (Vars.format formatEmpty formatArity) cSafety}"
  let tStart ← IO.monoMsNow
  let safetyCert? ← checkCircuitUnsatAux cSafety
  let tEnd ← IO.monoMsNow
  let tElapsedSec := (tEnd - tStart) / 1000
  trace[Bits.Fast] m!"Checked safety property in {tElapsedSec} seconds."
  match safetyCert? with
  | .none =>
    trace[Bits.Fast] s!"Safety property failed on initial state."
    return .safetyFailure iter
  | .some safetyCert =>
    trace[Bits.Fast] s!"Safety property succeeded on initial state. Building induction circuit..."

    let tStart ← IO.monoMsNow
    let cIndHyp := mkIndHypCircuit p iter
    let tEnd ← IO.monoMsNow
    let tElapsedSec := (tEnd - tStart) / 1000
    trace[Bits.Fast] m!"Built induction circuit in '{tElapsedSec}s'"

    let tStart ← IO.monoMsNow
    trace[Bits.Fast] m!"induction circuit: {formatCircuit (Vars.format formatα formatArity) cIndHyp}"
    -- let le : Bool := sorry
    let indCert? ← checkCircuitUnsatAux cIndHyp
    let tEnd ← IO.monoMsNow
    let tElapsedSec := (tEnd - tStart) / 1000
    trace[Bits.Fast] s!"Checked inductive invariant in '{tElapsedSec}s'."
    match indCert? with
    | .some indCert =>
      trace[Bits.Fast] s!"Inductive invariant established."
      return .proven iter safetyCert indCert
    | .none =>
      trace[Bits.Fast] s!"Unable to establish inductive invariant. Trying next iteration ({iter+1})..."
      decideIfZerosAuxTermElabMNew (iter + 1) maxIter p

@[nospecialize]
def _root_.FSM.decideIfZerosMCadicalNew  {arity : Type _} [DecidableEq arity]  [Fintype arity] [Hashable arity]
   (fsm : FSM arity) (maxIter : Nat) : TermElabM DecideIfZerosOutput :=
  -- decideIfZerosM Circuit.impliesCadical fsm
  withTraceNode `trace.Bits.Fast (fun _ => return "k-induction") (collapsed := false) do
    decideIfZerosAuxTermElabMNew 0 maxIter fsm

end BvDecide

end Reflect
