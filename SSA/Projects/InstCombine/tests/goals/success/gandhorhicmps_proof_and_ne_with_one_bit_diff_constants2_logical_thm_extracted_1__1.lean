
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_ne_with_one_bit_diff_constants2_logical_thm.extracted_1._1 : ∀ (x : BitVec 19),
  ofBool (x != 65#19) = 1#1 → ofBool (x != 193#19) = ofBool (x &&& BitVec.ofInt 19 (-129) != 65#19) :=
sorry