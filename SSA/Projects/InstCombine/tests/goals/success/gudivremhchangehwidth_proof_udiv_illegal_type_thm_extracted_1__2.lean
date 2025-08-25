
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem udiv_illegal_type_thm.extracted_1._2 : ∀ (x x_1 : BitVec 9),
  ¬zeroExtend 32 x = 0 → ¬x = 0 → zeroExtend 32 x_1 / zeroExtend 32 x = zeroExtend 32 (x_1 / x) :=
sorry