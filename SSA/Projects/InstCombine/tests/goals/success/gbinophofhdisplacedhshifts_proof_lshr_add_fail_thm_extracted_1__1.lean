
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_add_fail_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(x ≥ ↑8 ∨ x + 1#8 ≥ ↑8) →
    x ≥ ↑8 ∨
        x + 1#8 ≥ ↑8 ∨
          True ∧ (16#8 >>> x).saddOverflow (7#8 >>> (x + 1#8)) = true ∨
            True ∧ (16#8 >>> x).uaddOverflow (7#8 >>> (x + 1#8)) = true →
      False :=
sorry