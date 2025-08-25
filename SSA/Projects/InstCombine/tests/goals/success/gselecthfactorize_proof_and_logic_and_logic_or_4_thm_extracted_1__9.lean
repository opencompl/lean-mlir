
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_logic_and_logic_or_4_thm.extracted_1._9 : ∀ (x x_1 x_2 : BitVec 1),
  ¬x_2 &&& x_1 = 1#1 → ¬x = 1#1 → x_1 = 1#1 → ¬x_2 = 1#1 → 0#1 = x :=
sorry