
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_eq_with_one_bit_diff_constants3_logical_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (x == BitVec.ofInt 8 (-2)) = 1#1 → 1#1 = ofBool (x &&& 127#8 == 126#8) :=
sorry