
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem no_shift_xor_multiuse_or_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (0#32 != x_1 &&& 4096#32) = 1#1 →
    (x ||| 4096#32) * (x ||| 4096#32) = (x ||| x_1 &&& 4096#32 ^^^ 4096#32) * (x ||| 4096#32) :=
sorry