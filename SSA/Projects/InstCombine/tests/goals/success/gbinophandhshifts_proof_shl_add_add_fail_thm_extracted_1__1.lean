
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_add_add_fail_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(2#8 ≥ ↑8 ∨ 2#8 ≥ ↑8) →
    2#8 ≥ ↑8 ∨
        2#8 ≥ ↑8 ∨
          True ∧ (x >>> 2#8).saddOverflow 48#8 = true ∨
            True ∧ (x >>> 2#8).uaddOverflow 48#8 = true ∨ True ∧ (x_1 >>> 2#8).uaddOverflow (x >>> 2#8 + 48#8) = true →
      False :=
sorry