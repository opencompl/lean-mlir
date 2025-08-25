
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_ne_with_one_bit_diff_constants3_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (x != 65#8) &&& ofBool (x != BitVec.ofInt 8 (-63)) = ofBool (x &&& 127#8 != 65#8) :=
sorry