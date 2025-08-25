
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shift_xor_multiuse_cmp_with_and_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (0#32 != x_2 &&& 4096#32) = 1#1 → ofBool (x_2 &&& 4096#32 == 0#32) = 1#1 → False :=
sorry