
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem masked_bit_clear_commute_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬((x_1 == 0 || 32 != 1 && 42#32 == intMin 32 && x_1 == -1) = true ∨ x ≥ ↑32) →
    zeroExtend 32 (ofBool ((42#32).srem x_1 &&& 1#32 <<< x == 0#32)) = ((42#32).srem x_1 ^^^ -1#32) >>> x &&& 1#32 :=
sorry