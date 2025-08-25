
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t1_ult_slt_0_thm.extracted_1._8 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 + 16#32 <ᵤ 144#32) = 1#1 → ofBool (127#32 <ₛ x_2) = 1#1 → x_2 = x :=
sorry