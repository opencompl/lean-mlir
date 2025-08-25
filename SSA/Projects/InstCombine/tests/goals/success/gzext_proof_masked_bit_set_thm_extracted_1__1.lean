
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem masked_bit_set_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬x_1 ≥ ↑32 → zeroExtend 32 (ofBool (1#32 <<< x_1 &&& x != 0#32)) = x >>> x_1 &&& 1#32 :=
sorry