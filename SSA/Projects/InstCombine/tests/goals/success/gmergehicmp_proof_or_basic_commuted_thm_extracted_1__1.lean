
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_basic_commuted_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ofBool (x &&& BitVec.ofInt 16 (-256) != 32512#16) ||| ofBool (truncate 8 x != 69#8) = ofBool (x != 32581#16) :=
sorry