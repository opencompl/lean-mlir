
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem addsub_combine_constants_thm.extracted_1._1 : ∀ (x x_1 : BitVec 7),
  ¬(True ∧ (x_1 + 42#7).saddOverflow (10#7 - x) = true) → x_1 + 42#7 + (10#7 - x) = x_1 - x + 52#7 :=
sorry