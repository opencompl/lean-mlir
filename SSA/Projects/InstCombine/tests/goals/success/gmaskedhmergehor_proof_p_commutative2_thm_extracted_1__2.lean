
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem p_commutative2_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ¬(True ∧ (x_1 &&& (x_2 ^^^ -1#32) &&& (x &&& x_2) != 0) = true) →
    (x_2 ^^^ -1#32) &&& x_1 ||| x &&& x_2 = x_1 &&& (x_2 ^^^ -1#32) ||| x &&& x_2 :=
sorry