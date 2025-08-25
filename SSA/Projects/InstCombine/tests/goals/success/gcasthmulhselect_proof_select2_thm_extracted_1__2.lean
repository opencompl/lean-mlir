
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select2_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8) (x_2 : BitVec 1),
  x_2 = 1#1 → truncate 8 (zeroExtend 32 x_1) = x_1 :=
sorry