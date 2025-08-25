
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t2_ult_sgt_65536_thm.extracted_1._4 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 <ᵤ 65536#32) = 1#1 → ofBool (65535#32 <ₛ x_1) = 1#1 → False :=
sorry