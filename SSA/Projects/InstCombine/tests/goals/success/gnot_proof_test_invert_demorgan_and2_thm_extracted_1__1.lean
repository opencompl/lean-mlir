
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_invert_demorgan_and2_thm.extracted_1._1 : ∀ (x : BitVec 64),
  x + 9223372036854775807#64 &&& 9223372036854775807#64 ^^^ -1#64 =
    0#64 - x ||| BitVec.ofInt 64 (-9223372036854775808) :=
sorry