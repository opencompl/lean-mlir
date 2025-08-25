
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t4_ugt_slt_65536_thm.extracted_1._8 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (65535#32 <ᵤ x_1) = 1#1 → ofBool (65535#32 <ₛ x_1) = 1#1 → x_1 = x :=
sorry