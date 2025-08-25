
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zext_nneg_flag_drop_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 8),
  ¬(True ∧ (x_1 &&& 127#8).msb = true) →
    zeroExtend 16 (x_1 &&& 127#8) ||| x ||| 128#16 = x ||| zeroExtend 16 x_1 ||| 128#16 :=
sorry