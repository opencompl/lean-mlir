
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_tv_eq_thm.extracted_1._3 : ∀ (x x_1 : BitVec 8) (x_2 : BitVec 1),
  ¬x_2 = 1#1 → ¬(True ∧ x_1.uaddOverflow 1#8 = true) → ofBool (x_1 + 1#8 ||| x == 0#8) = ofBool (x == 0#8) &&& x_2 :=
sorry