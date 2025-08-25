
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shift_xor_multiuse_xor_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (0#32 != x_1 &&& 4096#32) = 1#1 →
    ofBool (x_1 &&& 4096#32 == 0#32) = 1#1 → x * (x ^^^ 2048#32) = (x ^^^ 2048#32) * (x ^^^ 2048#32) :=
sorry