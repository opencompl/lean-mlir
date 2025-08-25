
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_icmp_x_and_8_eq_0_y_xor_8_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 8#32 == 0#32) = 1#1 →
    ¬(True ∧ (x_1 &&& 8#32).msb = true) → x ^^^ 8#64 = x ^^^ zeroExtend 64 (x_1 &&& 8#32) :=
sorry