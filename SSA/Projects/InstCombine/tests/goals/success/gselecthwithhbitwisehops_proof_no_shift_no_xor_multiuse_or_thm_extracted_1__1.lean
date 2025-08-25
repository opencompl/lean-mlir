
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem no_shift_no_xor_multiuse_or_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 &&& 4096#32 == 0#32) = 1#1 → x * (x ||| 4096#32) = (x ||| x_1 &&& 4096#32) * (x ||| 4096#32) :=
sorry