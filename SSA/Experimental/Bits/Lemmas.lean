/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Mathlib.Data.Fintype.Card
import Mathlib.Data.Fintype.Sum
import Mathlib.Data.Fintype.Sigma
import Mathlib.Data.Fintype.BigOperators
import Mathlib.Tactic.Zify
import Mathlib.Tactic.Ring
import SSA.Experimental.Bits.Defs

open Term

lemma evalFin_eq_eval (t : Term) (vars : ℕ → ℕ → Bool) :
    Term.evalFin t (fun i => vars i) = Term.eval t vars := by
  induction t <;>
  dsimp [Term.evalFin, Term.eval, arity] at * <;> simp [*]

lemma eq_iff_xorSeq_eq_zero (seq₁ seq₂ : ℕ → Bool) :
    (∀ i, seq₁ i = seq₂ i) ↔ (∀ i, xorSeq seq₁ seq₂ i = zeroSeq i) := by
  simp [Function.funext_iff, xorSeq, zeroSeq]

lemma eval_eq_iff_xorSeq_eq_zero (t₁ t₂ : Term) :
    t₁.eval = t₂.eval ↔ (t₁.xor t₂).evalFin = λ _ => zeroSeq := by
  simp only [Function.funext_iff, Term.eval, Term.evalFin,
    ← eq_iff_xorSeq_eq_zero, ← evalFin_eq_eval]
  constructor
  { intro h seq n
    have := h (λ j => if hj : j < (arity (t₁.xor t₂)) then seq ⟨j, hj⟩ else λ _ => false) n
    simp at this
    convert this using 1 }
  { intro h seq m
    exact h (λ j => seq j) _ }
