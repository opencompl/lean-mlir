
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_and_xor_not_constant_commute1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 9),
  (x_1 ^^^ x) &&& 42#9 ||| x_1 &&& BitVec.ofInt 9 (-43) = x &&& 42#9 ^^^ x_1 :=
sorry