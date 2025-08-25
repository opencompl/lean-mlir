
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_wrong_const1_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ofBool (truncate 8 x != 127#8) ||| ofBool (x &&& BitVec.ofInt 16 (-256) != 17665#16) = 1#1 :=
sorry