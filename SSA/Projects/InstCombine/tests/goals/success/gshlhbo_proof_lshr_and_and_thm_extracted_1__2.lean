
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_and_and_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(2#8 ≥ ↑8 ∨ (42#8 == 0 || 8 != 1 && x == intMin 8 && 42#8 == -1) = true ∨ 2#8 ≥ ↑8) →
    ¬((42#8 == 0 || 8 != 1 && x == intMin 8 && 42#8 == -1) = true ∨ 2#8 ≥ ↑8) →
      (x_1 >>> 2#8 &&& 13#8 &&& x.srem 42#8) <<< 2#8 = x_1 &&& 52#8 &&& x.srem 42#8 <<< 2#8 :=
sorry