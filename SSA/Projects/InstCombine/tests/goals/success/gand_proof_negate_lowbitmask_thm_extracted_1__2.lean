
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem negate_lowbitmask_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬ofBool (x_1 &&& 1#8 == 0#8) = 1#1 → 0#8 - (x_1 &&& 1#8) &&& x = x :=
sorry