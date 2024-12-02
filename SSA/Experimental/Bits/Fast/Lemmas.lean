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

/--
Build a list `[f 0, f 1, ... ]`  of length `size`.
-/
def List.ofFn' (f : Nat → α) (size : Nat) : List α :=
  List.ofFn (n := size) (fun i => f i)

lemma Term.evalFin_eq_eval (t : Term) (vars : Nat → BitStream) :
    Term.evalFin t (fun i => vars i) = Term.eval t (List.ofFn' vars t.arity) := by
  induction t <;>
    dsimp [Term.evalFin, Term.eval, arity] at * <;> sorry

lemma Predicate.evalFin_eq_eval (p : Predicate) (vars : Nat → BitStream) :
    Predicate.evalFin p (fun i => vars i) = Predicate.eval p (List.ofFn' vars p.arity) := by
  induction p <;> sorry

lemma eq_iff_xor_eq_zero (seq₁ seq₂ : BitStream) :
    (∀ i, seq₁ i = seq₂ i) ↔ (∀ i, (seq₁ ^^^ seq₂) i = BitStream.zero i) := by
  simp [funext_iff]

lemma eval_eq_iff_xor_eq_zero (t₁ t₂ : Term) :
    t₁.eval = t₂.eval ↔ (t₁.xor t₂).evalFin = fun _ => BitStream.zero := by
  simp only [funext_iff, Term.eval, Term.evalFin,
    ← eq_iff_xor_eq_zero, ← evalFin_eq_eval]
  constructor <;> sorry
