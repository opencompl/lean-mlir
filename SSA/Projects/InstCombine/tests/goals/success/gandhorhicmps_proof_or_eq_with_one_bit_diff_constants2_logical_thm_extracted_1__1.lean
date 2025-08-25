
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_eq_with_one_bit_diff_constants2_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x == 97#32) = 1#1 → 1#1 = ofBool (x &&& BitVec.ofInt 32 (-33) == 65#32) :=
sorry