
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sdiv_x_by_const_cmp_x_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(13#32 == 0 || 32 != 1 && x == intMin 32 && 13#32 == -1) = true → ofBool (x.sdiv 13#32 == x) = ofBool (x == 0#32) :=
sorry