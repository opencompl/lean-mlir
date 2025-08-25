
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR38021_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬3#8 ≥ ↑8 →
    3#8 ≥ ↑8 ∨
        True ∧ (x >>> 3#8).saddOverflow (BitVec.ofInt 8 (-63)) = true ∨
          True ∧ (x >>> 3#8).uaddOverflow (BitVec.ofInt 8 (-63)) = true →
      False :=
sorry