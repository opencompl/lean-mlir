
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_sandwich_big_sum_shift1_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(21#32 ≥ ↑32 ∨ 11#12 ≥ ↑12) → truncate 12 (x >>> 21#32) >>> 11#12 = 0#12 :=
sorry