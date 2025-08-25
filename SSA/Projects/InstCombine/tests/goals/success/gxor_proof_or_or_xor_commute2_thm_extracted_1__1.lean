
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_or_xor_commute2_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 4),
  (x_2 ||| x_1) ^^^ (x ||| x_2) = (x_1 ^^^ x) &&& (x_2 ^^^ -1#4) :=
sorry