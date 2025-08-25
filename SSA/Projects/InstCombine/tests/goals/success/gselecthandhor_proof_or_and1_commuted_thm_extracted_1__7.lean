
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_and1_commuted_thm.extracted_1._7 : ∀ (x x_1 x_2 : BitVec 1),
  ¬x_2 &&& (x_1 ^^^ 1#1) = 1#1 → ¬x_1 = 1#1 → x_2 = 1#1 → x_1 = x :=
sorry