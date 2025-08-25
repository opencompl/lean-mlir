
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem no_shift_xor_multiuse_cmp_and_thm.extracted_1._3 : ∀ (x x_1 x_2 x_3 : BitVec 32),
  ofBool (0#32 != x_3 &&& 4096#32) = 1#1 →
    ofBool (x_3 &&& 4096#32 == 0#32) = 1#1 →
      x_2 * x_1 * (x_2 &&& BitVec.ofInt 32 (-4097)) =
        (x_2 &&& BitVec.ofInt 32 (-4097)) * x * (x_2 &&& BitVec.ofInt 32 (-4097)) :=
sorry