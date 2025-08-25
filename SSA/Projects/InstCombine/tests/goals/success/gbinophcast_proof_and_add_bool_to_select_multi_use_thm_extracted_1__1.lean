
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_add_bool_to_select_multi_use_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  x_1 = 1#1 → (-1#32 + zeroExtend 32 x_1 &&& x) + (-1#32 + zeroExtend 32 x_1) = 0#32 :=
sorry