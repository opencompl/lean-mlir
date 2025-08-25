
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test95_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬6#8 ≥ ↑8 →
    6#8 ≥ ↑8 ∨
        True ∧ (truncate 8 x >>> 6#8 &&& 2#8 &&& 40#8 != 0) = true ∨
          True ∧ (truncate 8 x >>> 6#8 &&& 2#8 ||| 40#8).msb = true →
      False :=
sorry