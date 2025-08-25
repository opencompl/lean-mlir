
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem no_shift_xor_multiuse_and_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (0#32 != x_1 &&& 4096#32) = 1#1 →
    ofBool (x_1 &&& 4096#32 == 0#32) = 1#1 →
      x * (x &&& BitVec.ofInt 32 (-4097)) = (x &&& BitVec.ofInt 32 (-4097)) * (x &&& BitVec.ofInt 32 (-4097)) :=
sorry