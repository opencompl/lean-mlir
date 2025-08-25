
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_basic_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ofBool (truncate 8 x != 127#8) ||| ofBool (x &&& BitVec.ofInt 16 (-256) != 17664#16) = ofBool (x != 17791#16) :=
sorry