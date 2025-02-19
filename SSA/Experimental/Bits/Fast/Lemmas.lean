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
abbrev List.ofFn' (f : Nat → α) (size : Nat) : List α :=
  List.ofFn (n := size) (fun i => f i)


lemma Term.evalFin_eq_eval (t : Term) 
   (varsList : List BitStream) (varsFin : Fin t.arity → BitStream)
   (hvars : ∀ (i : Fin t.arity), varsList.getD i default = (varsFin i)) :
    Term.evalFin t varsFin = Term.eval t varsList := by
  induction t generalizing varsList <;>
    dsimp [Term.evalFin, Term.eval, arity] at *
  case var i => rw [← hvars]; simp
  case and a b ha hb => 
    rw [ha varsList]
    · rw [hb varsList]
      intros i
      have := hvars ⟨i, by omega⟩
      rw [this]
      rfl
    · intros i
      have := hvars ⟨i, by omega⟩
      rw [this]
      rfl
  case or a b ha hb =>
    rw [ha varsList]
    · rw [hb varsList]
      intros i
      have := hvars ⟨i, by omega⟩
      rw [this]
      rfl
    · intros i
      have := hvars ⟨i, by omega⟩
      rw [this]
      rfl
  case xor a b ha hb =>
    rw [ha varsList]
    · rw [hb varsList]
      intros i
      have := hvars ⟨i, by omega⟩
      rw [this]
      rfl
    · intros i
      have := hvars ⟨i, by omega⟩
      rw [this]
      rfl
  case not a ha => rw [ha varsList _ hvars]
  case neg a ha => rw [ha varsList _ hvars]
  case shiftL k a ha => rw [ha varsList _ hvars]
  case ls a b ha =>
    rw [ha varsList]
    intros i
    -- TODO: make this into simp normal form
    rw [hvars]
  case add a b ha hb =>
    rw [ha varsList]
    · rw [hb varsList]
      intros i
      have := hvars ⟨i, by omega⟩
      rw [this]
      rfl
    · intros i
      have := hvars ⟨i, by omega⟩
      rw [this]
      rfl
  case sub a b ha hb =>
    rw [ha varsList]
    · rw [hb varsList]
      intros i
      have := hvars ⟨i, by omega⟩
      rw [this]
      rfl
    · intros i
      have := hvars ⟨i, by omega⟩
      rw [this]
      rfl

/-- info: 'Term.evalFin_eq_eval' depends on axioms: [propext, Quot.sound] -/
#guard_msgs in #print axioms Term.evalFin_eq_eval 

lemma Predicate.evalFin_eq_eval (p : Predicate)
   (varsList : List BitStream) (varsFin : Fin p.arity → BitStream)
   (hvars : ∀ (i : Fin p.arity), varsList.getD i default = (varsFin i)) :
    Predicate.evalFin p varsFin  = Predicate.eval p varsList := by
  induction p generalizing varsList <;>
    dsimp [Predicate.evalFin, Predicate.eval, Predicate.arity] at *
  case eq =>
    simp [evalEq]
    rw [Term.evalFin_eq_eval _ varsList]
    · rw [Term.evalFin_eq_eval _ varsList]
      · intros i
        rw [hvars ⟨i, by omega⟩]
        rfl
    · intros i
      rw [hvars ⟨i, by omega⟩]
      rfl
  case neq =>
    simp [evalNeq]
    rw [Term.evalFin_eq_eval _ varsList]
    · rw [Term.evalFin_eq_eval _ varsList]
      · intros i
        rw [hvars ⟨i, by omega⟩]
        rfl
    · intros i
      rw [hvars ⟨i, by omega⟩]
      rfl
  case land p q hp hq =>
    simp [evalLand]
    rw [hp varsList]
    · rw [hq varsList]
      · intros i
        rw [hvars ⟨i, by omega⟩]
        rfl
    · intros i
      rw [hvars ⟨i, by omega⟩]
      rfl
  case lor p q hp hq =>
    simp [evalLor]
    rw [hp varsList]
    · rw [hq varsList]
      · intros i
        rw [hvars ⟨i, by omega⟩]
        rfl
    · intros i
      rw [hvars ⟨i, by omega⟩]
      rfl
  case ult =>
    simp [evalUlt]
    rw [Term.evalFin_eq_eval _ varsList]
    · rw [Term.evalFin_eq_eval _ varsList]
      intros i 
      rw [hvars ⟨i, by omega⟩]
      rfl
    · intros i
      rw [hvars ⟨i, by omega⟩]
      rfl
  case slt =>
    simp [evalSlt]
    rw [Term.evalFin_eq_eval _ varsList]
    · rw [Term.evalFin_eq_eval _ varsList]
      intros i 
      rw [hvars ⟨i, by omega⟩]
      rfl
    · intros i
      rw [hvars ⟨i, by omega⟩]
      rfl
  case ule =>
    simp [evalUlt, evalEq]
    rw [Term.evalFin_eq_eval _ varsList]
    · rw [Term.evalFin_eq_eval _ varsList]
      · simp [evalLor]
        rw [BitStream.and_comm]
      · intros i
        rw [hvars ⟨i, by omega⟩]
        rfl
    · intros i
      rw [hvars ⟨i, by omega⟩]
      rfl
  case sle =>
    simp [evalUlt, evalEq]
    rw [Term.evalFin_eq_eval _ varsList]
    · rw [Term.evalFin_eq_eval _ varsList]
      · simp [evalSlt, evalLor]
        rw [BitStream.and_comm]
      · intros i
        rw [hvars ⟨i, by omega⟩]
        rfl
    · intros i
      rw [hvars ⟨i, by omega⟩]
      rfl

/-- info: 'Predicate.evalFin_eq_eval' depends on axioms: [propext, Quot.sound] -/
#guard_msgs in #print axioms Predicate.evalFin_eq_eval


lemma eq_iff_xor_eq_zero (seq₁ seq₂ : BitStream) :
    (∀ i, seq₁ i = seq₂ i) ↔ (∀ i, (seq₁ ^^^ seq₂) i = BitStream.zero i) := by
  simp [funext_iff]
