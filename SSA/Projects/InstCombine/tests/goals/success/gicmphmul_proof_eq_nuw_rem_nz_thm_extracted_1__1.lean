
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem eq_nuw_rem_nz_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x.umulOverflow (BitVec.ofInt 8 (-5)) = true) → ofBool (x * BitVec.ofInt 8 (-5) == 20#8) = 0#1 :=
sorry