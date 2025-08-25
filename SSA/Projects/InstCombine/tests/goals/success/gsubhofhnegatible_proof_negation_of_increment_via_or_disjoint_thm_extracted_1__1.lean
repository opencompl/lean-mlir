
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem negation_of_increment_via_or_disjoint_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ (x &&& 1#8 != 0) = true) → x_1 - (x ||| 1#8) = x_1 + (x ^^^ -1#8) :=
sorry