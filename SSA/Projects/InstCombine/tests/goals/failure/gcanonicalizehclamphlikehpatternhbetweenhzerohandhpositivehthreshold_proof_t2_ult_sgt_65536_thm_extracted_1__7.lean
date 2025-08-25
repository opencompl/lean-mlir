
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t2_ult_sgt_65536_thm.extracted_1._7 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 <ᵤ 65536#32) = 1#1 → ofBool (65535#32 <ₛ x_2) = 1#1 → x_2 = x_1 :=
sorry