
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem eq_21_logical_thm.extracted_1._3 : ∀ (x x_1 : BitVec 32),
  ¬(16#32 ≥ ↑32 ∨ 16#32 ≥ ↑32) →
    ¬ofBool (truncate 8 (x_1 >>> 16#32) == truncate 8 (x >>> 16#32)) = 1#1 →
      ¬(8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) → 0#1 = ofBool (truncate 16 (x_1 >>> 8#32) == truncate 16 (x >>> 8#32)) :=
sorry