
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem a_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(8#32 == 0 || 32 != 1 && x == intMin 32 && 8#32 == -1) = true → x.srem 8#32 &&& 1#32 = x &&& 1#32 :=
sorry