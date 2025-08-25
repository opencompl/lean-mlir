
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem bools_multi_uses2_logical_thm.extracted_1._32 : ∀ (x x_1 x_2 : BitVec 1),
  ¬x_2 ^^^ 1#1 = 1#1 → x_2 = 1#1 → ¬0#1 = 1#1 → x = 1#1 → 0#1 + x = 0#1 ^^^ x :=
sorry