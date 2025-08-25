
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_and_add_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬((42#8 == 0 || 8 != 1 && x_1 == intMin 8 && 42#8 == -1) = true ∨ 3#8 ≥ ↑8 ∨ 3#8 ≥ ↑8) →
    ¬((42#8 == 0 || 8 != 1 && x_1 == intMin 8 && 42#8 == -1) = true ∨ 3#8 ≥ ↑8) →
      (x_1.srem 42#8 + (x >>> 3#8 &&& 12#8)) <<< 3#8 = (x &&& 96#8) + x_1.srem 42#8 <<< 3#8 :=
sorry