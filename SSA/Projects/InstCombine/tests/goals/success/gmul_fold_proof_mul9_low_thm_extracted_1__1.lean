
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul9_low_thm.extracted_1._1 : ∀ (x x_1 : BitVec 9),
  ¬(4#9 ≥ ↑9 ∨ 4#9 ≥ ↑9 ∨ 4#9 ≥ ↑9) →
    4#9 ≥ ↑9 ∨
        True ∧ (x_1 >>> 4#9).umulOverflow (x &&& 15#9) = true ∨
          4#9 ≥ ↑9 ∨
            True ∧ (x_1 &&& 15#9).umulOverflow (x >>> 4#9) = true ∨
              4#9 ≥ ↑9 ∨
                True ∧ (x_1 &&& 15#9).smulOverflow (x &&& 15#9) = true ∨
                  True ∧ (x_1 &&& 15#9).umulOverflow (x &&& 15#9) = true →
      False :=
sorry