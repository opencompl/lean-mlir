
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ne_nuw_rem_nz_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x.umulOverflow 5#8 = true) → ofBool (x * 5#8 != BitVec.ofInt 8 (-30)) = 1#1 :=
sorry