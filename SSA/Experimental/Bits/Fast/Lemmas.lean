/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Mathlib.Data.Fintype.Card
import Mathlib.Data.Fintype.Sum
import Mathlib.Data.Fintype.Sigma
import Mathlib.Data.Fintype.BigOperators
import Mathlib.Tactic.Zify
import Mathlib.Tactic.Ring
import SSA.Experimental.Bits.Fast.Defs
import SSA.Experimental.Bits.Fast.BitStream

open Term

lemma Term.evalFin_eq_eval (t : Term) (vars : Nat → BitStream) :
    Term.evalFin t (fun i => vars i) = Term.eval t vars := by
  induction t <;>
    dsimp [Term.evalFin, Term.eval, arity] at * <;> simp [*]

lemma Predicate.evalFin_eq_eval (p : Predicate) (vars : Nat → BitStream) :
    Predicate.evalFin p (fun i => vars i) = Predicate.eval p vars := by
  induction p
  · dsimp [Predicate.evalFin, Predicate.eval, arity] at *
    repeat rw [Term.evalFin_eq_eval]
  · dsimp [Predicate.evalFin, Predicate.eval, arity] at *
    repeat rw [Term.evalFin_eq_eval]
  · dsimp [Predicate.evalFin, Predicate.eval, arity] at *
    repeat rw [Term.evalFin_eq_eval]
  · dsimp [Predicate.evalFin, Predicate.eval, arity] at *
    simp [*]
  · dsimp [Predicate.evalFin, Predicate.eval, arity] at *
    simp [*]


lemma eq_iff_xor_eq_zero (seq₁ seq₂ : BitStream) :
    (∀ i, seq₁ i = seq₂ i) ↔ (∀ i, (seq₁ ^^^ seq₂) i = BitStream.zero i) := by
  simp [funext_iff]

lemma eval_eq_iff_xor_eq_zero (t₁ t₂ : Term) :
    t₁.eval = t₂.eval ↔ (t₁.xor t₂).evalFin = fun _ => BitStream.zero := by
  simp only [funext_iff, Term.eval, Term.evalFin,
    ← eq_iff_xor_eq_zero, ← evalFin_eq_eval]
  constructor
  · intro h seq
    ext j
    simp only [arity.eq_7, BitStream.xor_eq, BitStream.zero_eq, bne_eq_false_iff_eq]
    apply congr_fun
    simpa using h (fun j => if hj : j < (arity (t₁.xor t₂)) then seq ⟨j, hj⟩ else fun _ => false)
  · intro h seq
    ext j
    have := h (seq ·)
    apply_fun (· j) at this
    simpa
