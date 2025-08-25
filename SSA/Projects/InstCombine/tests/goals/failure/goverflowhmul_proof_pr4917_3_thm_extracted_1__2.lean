
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem pr4917_3_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (4294967295#64 <ᵤ zeroExtend 64 x_1 * zeroExtend 64 x) = 1#1 →
    True ∧ (zeroExtend 64 x_1).umulOverflow (zeroExtend 64 x) = true → False :=
sorry