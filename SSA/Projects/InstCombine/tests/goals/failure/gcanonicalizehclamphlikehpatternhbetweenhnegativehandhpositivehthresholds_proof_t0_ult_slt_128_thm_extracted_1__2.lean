
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t0_ult_slt_128_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 + 16#32 <ᵤ 144#32) = 1#1 → ofBool (127#32 <ₛ x_1) = 1#1 → False :=
sorry