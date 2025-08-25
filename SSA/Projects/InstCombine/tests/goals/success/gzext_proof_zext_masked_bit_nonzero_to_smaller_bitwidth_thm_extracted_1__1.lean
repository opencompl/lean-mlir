
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zext_masked_bit_nonzero_to_smaller_bitwidth_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬x_1 ≥ ↑32 → zeroExtend 16 (ofBool (1#32 <<< x_1 &&& x != 0#32)) = truncate 16 (x >>> x_1) &&& 1#16 :=
sorry