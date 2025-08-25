
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t7_ugt_sgt_neg1_thm.extracted_1._13 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (65535#32 <ᵤ x_2) = 1#1 →
    ¬ofBool (-1#32 <ₛ x_2) = 1#1 → ¬ofBool (65535#32 <ₛ x_2) = 1#1 → ¬ofBool (x_2 <ₛ 0#32) = 1#1 → x = x_2 :=
sorry