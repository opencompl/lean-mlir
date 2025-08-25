
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t3_ult_sgt_neg1_thm.extracted_1._12 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 + 16#32 <ᵤ 144#32) = 1#1 →
    ofBool (BitVec.ofInt 32 (-17) <ₛ x_2) = 1#1 →
      ¬ofBool (127#32 <ₛ x_2) = 1#1 → ofBool (x_2 <ₛ BitVec.ofInt 32 (-16)) = 1#1 → x_1 = x :=
sorry