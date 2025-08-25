
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t1_ult_slt_0_thm.extracted_1._6 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 + 16#32 <ᵤ 144#32) = 1#1 →
    ¬ofBool (127#32 <ₛ x_1) = 1#1 → ofBool (x_1 <ₛ BitVec.ofInt 32 (-16)) = 1#1 → False :=
sorry