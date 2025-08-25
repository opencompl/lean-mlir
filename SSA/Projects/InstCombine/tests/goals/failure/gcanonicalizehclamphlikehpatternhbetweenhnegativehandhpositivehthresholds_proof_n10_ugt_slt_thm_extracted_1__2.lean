
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem n10_ugt_slt_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (128#32 <ᵤ x_2) = 1#1 → ofBool (x_2 <ₛ 0#32) = 1#1 → x_1 = x :=
sorry