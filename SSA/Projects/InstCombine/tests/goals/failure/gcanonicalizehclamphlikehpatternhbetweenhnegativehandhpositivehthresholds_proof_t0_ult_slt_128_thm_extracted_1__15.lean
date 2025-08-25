
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t0_ult_slt_128_thm.extracted_1._15 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 + 16#32 <ᵤ 144#32) = 1#1 →
    ¬ofBool (x_2 <ₛ 128#32) = 1#1 →
      ¬ofBool (127#32 <ₛ x_2) = 1#1 → ¬ofBool (x_2 <ₛ BitVec.ofInt 32 (-16)) = 1#1 → x = x_2 :=
sorry