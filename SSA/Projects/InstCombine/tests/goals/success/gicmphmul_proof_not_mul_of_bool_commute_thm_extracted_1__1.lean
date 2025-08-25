
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem not_mul_of_bool_commute_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬30#32 ≥ ↑32 →
    30#32 ≥ ↑32 ∨
        True ∧ (x_1 &&& 255#32).smulOverflow (x >>> 30#32) = true ∨
          True ∧ (x_1 &&& 255#32).umulOverflow (x >>> 30#32) = true →
      False :=
sorry