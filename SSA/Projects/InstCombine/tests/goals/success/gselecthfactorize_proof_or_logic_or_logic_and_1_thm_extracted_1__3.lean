
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_logic_or_logic_and_1_thm.extracted_1._3 : ∀ (x x_1 x_2 : BitVec 1),
  x_2 ||| x_1 = 1#1 → ¬x_2 = 1#1 → ¬x_1 = 1#1 → x = 0#1 :=
sorry