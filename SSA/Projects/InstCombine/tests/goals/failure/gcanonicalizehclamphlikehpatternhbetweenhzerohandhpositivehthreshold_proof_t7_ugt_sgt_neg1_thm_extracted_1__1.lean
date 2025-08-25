
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t7_ugt_sgt_neg1_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬ofBool (65535#32 <ᵤ x) = 1#1 → ofBool (65535#32 <ₛ x) = 1#1 ∨ ofBool (x <ₛ 0#32) = 1#1 → False :=
sorry