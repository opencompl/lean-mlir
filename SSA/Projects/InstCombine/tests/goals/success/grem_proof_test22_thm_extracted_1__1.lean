
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test22_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(2147483647#32 == 0 || 32 != 1 && x &&& 2147483647#32 == intMin 32 && 2147483647#32 == -1) = true →
    2147483647#32 = 0 → False :=
sorry