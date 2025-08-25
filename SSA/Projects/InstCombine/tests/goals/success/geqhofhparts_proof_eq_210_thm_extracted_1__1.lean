
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem eq_210_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(16#32 ≥ ↑32 ∨ 16#32 ≥ ↑32 ∨ 8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
    ofBool (truncate 8 (x_1 >>> 16#32) == truncate 8 (x >>> 16#32)) &&&
        (ofBool (truncate 8 x_1 == truncate 8 x) &&& ofBool (truncate 8 (x_1 >>> 8#32) == truncate 8 (x >>> 8#32))) =
      ofBool (truncate 24 x_1 == truncate 24 x) :=
sorry