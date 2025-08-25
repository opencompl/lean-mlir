
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t3_ult_sgt_neg1_thm.extracted_1._8 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 + 16#32 <ᵤ 144#32) = 1#1 →
    ¬ofBool (BitVec.ofInt 32 (-17) <ₛ x_1) = 1#1 → ofBool (127#32 <ₛ x_1) = 1#1 → False :=
sorry