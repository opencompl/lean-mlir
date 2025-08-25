
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_eq_with_one_bit_diff_constants1_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x == 50#32) ||| ofBool (x == 51#32) = ofBool (x &&& BitVec.ofInt 32 (-2) == 50#32) :=
sorry