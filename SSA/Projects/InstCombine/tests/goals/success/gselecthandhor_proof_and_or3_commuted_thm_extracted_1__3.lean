
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_or3_commuted_thm.extracted_1._3 : ∀ (x : BitVec 1) (x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 == x_1) &&& x = 1#1 → ¬x = 1#1 → x = 0#1 :=
sorry