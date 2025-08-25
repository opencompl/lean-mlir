
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ne_10_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
    ofBool (truncate 8 x_1 != truncate 8 x) ||| ofBool (truncate 8 (x_1 >>> 8#32) != truncate 8 (x >>> 8#32)) =
      ofBool (truncate 16 x_1 != truncate 16 x) :=
sorry