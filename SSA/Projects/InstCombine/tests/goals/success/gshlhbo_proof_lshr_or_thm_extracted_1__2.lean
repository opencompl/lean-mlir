
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_or_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬((42#8 == 0 || 8 != 1 && x_1 == intMin 8 && 42#8 == -1) = true ∨ 4#8 ≥ ↑8 ∨ 4#8 ≥ ↑8) →
    ¬((42#8 == 0 || 8 != 1 && x_1 == intMin 8 && 42#8 == -1) = true ∨ 4#8 ≥ ↑8) →
      (x_1.srem 42#8 ||| x >>> 4#8) <<< 4#8 = x &&& BitVec.ofInt 8 (-16) ||| x_1.srem 42#8 <<< 4#8 :=
sorry