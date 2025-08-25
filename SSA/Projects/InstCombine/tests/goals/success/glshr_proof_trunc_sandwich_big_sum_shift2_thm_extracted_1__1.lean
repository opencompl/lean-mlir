
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_sandwich_big_sum_shift2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(31#32 ≥ ↑32 ∨ 1#12 ≥ ↑12) → truncate 12 (x >>> 31#32) >>> 1#12 = 0#12 :=
sorry