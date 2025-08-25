
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shift_xor_multiuse_and_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (0#32 != x_1 &&& 4096#32) = 1#1 →
    ¬ofBool (x_1 &&& 4096#32 == 0#32) = 1#1 →
      (x &&& BitVec.ofInt 32 (-2049)) * (x &&& BitVec.ofInt 32 (-2049)) = x * (x &&& BitVec.ofInt 32 (-2049)) :=
sorry