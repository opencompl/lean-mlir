
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem only_one_masked_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ofBool (x != 0#64) &&& ofBool (x &&& 9223372036854775807#64 == 0#64) =
    ofBool (x == BitVec.ofInt 64 (-9223372036854775808)) :=
sorry