
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test7_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(4#32 == 0 || 32 != 1 && x * 8#32 == intMin 32 && 4#32 == -1) = true → (x * 8#32).srem 4#32 = 0#32 :=
sorry