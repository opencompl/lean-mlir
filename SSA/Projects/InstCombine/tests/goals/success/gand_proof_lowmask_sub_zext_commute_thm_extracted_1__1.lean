
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lowmask_sub_zext_commute_thm.extracted_1._1 : ∀ (x : BitVec 5) (x_1 : BitVec 17),
  x_1 - zeroExtend 17 x &&& 31#17 = zeroExtend 17 (truncate 5 x_1 - x) :=
sorry