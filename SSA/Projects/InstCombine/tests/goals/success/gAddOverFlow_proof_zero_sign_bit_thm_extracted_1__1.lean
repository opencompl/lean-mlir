
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zero_sign_bit_thm.extracted_1._1 : ∀ (x : BitVec 16),
  True ∧ (x &&& 32767#16).uaddOverflow 512#16 = true → False :=
sorry