
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ne_shift_in_zeros_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(16#32 ≥ ↑32 ∨ 16#32 ≥ ↑32 ∨ 8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
    ofBool (truncate 24 (x_1 >>> 16#32) != truncate 24 (x >>> 16#32)) |||
        ofBool (truncate 8 (x_1 >>> 8#32) != truncate 8 (x >>> 8#32)) =
      ofBool (255#32 <ᵤ x_1 ^^^ x) :=
sorry