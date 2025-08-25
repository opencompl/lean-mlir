
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t1_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬ofBool (x &&& 31#8 == 0#8) = 1#1 → x + 32#8 &&& BitVec.ofInt 8 (-32) = x + 31#8 &&& BitVec.ofInt 8 (-32) :=
sorry