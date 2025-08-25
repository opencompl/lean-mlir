
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_eq_with_one_bit_diff_constants1_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x == 50#32) = 1#1 → ofBool (x == 51#32) = ofBool (x &&& BitVec.ofInt 32 (-2) == 50#32) :=
sorry