
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_and_xor_not_constant_commute0_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  (x_1 ^^^ x) &&& 1#32 ||| x &&& BitVec.ofInt 32 (-2) = x_1 &&& 1#32 ^^^ x :=
sorry