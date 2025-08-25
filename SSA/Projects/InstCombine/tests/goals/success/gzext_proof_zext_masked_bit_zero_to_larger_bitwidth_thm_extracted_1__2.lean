
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zext_masked_bit_zero_to_larger_bitwidth_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬x_1 ≥ ↑32 →
    ¬(x_1 ≥ ↑32 ∨ True ∧ ((x ^^^ -1#32) >>> x_1 &&& 1#32).msb = true) →
      zeroExtend 64 (ofBool (1#32 <<< x_1 &&& x == 0#32)) = zeroExtend 64 ((x ^^^ -1#32) >>> x_1 &&& 1#32) :=
sorry