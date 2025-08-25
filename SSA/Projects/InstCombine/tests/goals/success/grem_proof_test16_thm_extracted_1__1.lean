
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test16_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(11#32 ≥ ↑32 ∨ (x >>> 11#32 &&& 4#32) + 4#32 = 0) →
    11#32 ≥ ↑32 ∨ True ∧ (x >>> 11#32 &&& 4#32 &&& 3#32 != 0) = true → False :=
sorry