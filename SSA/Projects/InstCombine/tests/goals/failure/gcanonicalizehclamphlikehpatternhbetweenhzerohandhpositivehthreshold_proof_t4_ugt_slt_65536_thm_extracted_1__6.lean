
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t4_ugt_slt_65536_thm.extracted_1._6 : ∀ (x x_1 : BitVec 32),
  ofBool (65535#32 <ᵤ x_1) = 1#1 →
    ¬ofBool (x_1 <ₛ 65536#32) = 1#1 → ¬ofBool (65535#32 <ₛ x_1) = 1#1 → ofBool (x_1 <ₛ 0#32) = 1#1 → False :=
sorry