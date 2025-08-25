
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test6_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬3#32 ≥ ↑32 →
    3#32 ≥ ↑32 ∨
        True ∧ (x >>> 3#32).smulOverflow 3#32 = true ∨
          True ∧ (x >>> 3#32).umulOverflow 3#32 = true ∨ True ∧ (x >>> 3#32 * 3#32).msb = true →
      False :=
sorry