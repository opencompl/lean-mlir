
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test8_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(4#32 ≥ ↑32 ∨ (8#32 == 0 || 32 != 1 && x <<< 4#32 == intMin 32 && 8#32 == -1) = true) →
    (x <<< 4#32).srem 8#32 = 0#32 :=
sorry