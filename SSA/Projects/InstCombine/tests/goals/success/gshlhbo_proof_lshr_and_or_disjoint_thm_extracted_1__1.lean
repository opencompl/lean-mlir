
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_and_or_disjoint_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬((42#8 == 0 || 8 != 1 && x_1 == intMin 8 && 42#8 == -1) = true ∨
        2#8 ≥ ↑8 ∨ True ∧ (x_1.srem 42#8 &&& (x >>> 2#8 &&& 13#8) != 0) = true ∨ 2#8 ≥ ↑8) →
    (42#8 == 0 || 8 != 1 && x_1 == intMin 8 && 42#8 == -1) = true ∨
        2#8 ≥ ↑8 ∨ True ∧ (x &&& 52#8 &&& x_1.srem 42#8 <<< 2#8 != 0) = true →
      False :=
sorry