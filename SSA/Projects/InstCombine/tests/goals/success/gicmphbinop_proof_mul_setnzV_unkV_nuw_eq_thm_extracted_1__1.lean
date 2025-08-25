
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul_setnzV_unkV_nuw_eq_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ (x_1 ||| 2#8).umulOverflow x = true) → ofBool ((x_1 ||| 2#8) * x == 0#8) = ofBool (x == 0#8) :=
sorry