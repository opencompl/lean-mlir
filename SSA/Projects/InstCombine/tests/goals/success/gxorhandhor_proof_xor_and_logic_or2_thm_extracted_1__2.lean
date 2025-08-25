
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem xor_and_logic_or2_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 1),
  x = 1#1 → ¬x_1 = 1#1 → x_2 &&& x_1 ^^^ 1#1 = x :=
sorry