
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_orn_xor_thm.extracted_1._1 : ∀ (x x_1 : BitVec 4),
  (x_1 ^^^ -1#4 ||| x) &&& (x_1 ^^^ x) = x &&& (x_1 ^^^ -1#4) :=
sorry