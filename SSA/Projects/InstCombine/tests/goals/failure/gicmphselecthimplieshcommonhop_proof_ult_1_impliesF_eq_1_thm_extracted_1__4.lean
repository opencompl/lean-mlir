
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ult_1_impliesF_eq_1_thm.extracted_1._4 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 <ᵤ 1#8) = 1#1 → ¬ofBool (x_1 != 0#8) = 1#1 → ofBool (x_1 == 1#8) = 0#1 :=
sorry