
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_or_and_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(5#8 ≥ ↑8 ∨ 5#8 ≥ ↑8) →
    ¬5#8 ≥ ↑8 → (x_1 >>> 5#8 ||| BitVec.ofInt 8 (-58)) &&& x >>> 5#8 = (x &&& (x_1 ||| BitVec.ofInt 8 (-64))) >>> 5#8 :=
sorry