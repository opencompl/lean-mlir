
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sub_to_and_or_commuted_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  (x_1 ^^^ x) - (x ||| x_1) = 0#32 - (x_1 &&& x) :=
sorry