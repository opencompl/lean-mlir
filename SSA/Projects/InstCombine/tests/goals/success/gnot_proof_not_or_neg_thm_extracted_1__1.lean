
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem not_or_neg_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  (0#8 - x_1 ||| x) ^^^ -1#8 = x_1 + -1#8 &&& (x ^^^ -1#8) :=
sorry