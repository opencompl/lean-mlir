
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t6_ugt_sgt_65536_thm.extracted_1._8 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (65535#32 <ᵤ x_2) = 1#1 → ofBool (65535#32 <ₛ x_2) = 1#1 → x_2 = x_1 :=
sorry