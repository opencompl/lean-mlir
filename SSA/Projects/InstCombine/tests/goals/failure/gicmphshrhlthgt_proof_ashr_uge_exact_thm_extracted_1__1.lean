
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_uge_exact_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x >>> 3#8 <<< 3#8 ≠ x ∨ 3#8 ≥ ↑8) → ofBool (10#8 ≤ᵤ x.sshiftRight' 3#8) = ofBool (72#8 <ᵤ x) :=
sorry