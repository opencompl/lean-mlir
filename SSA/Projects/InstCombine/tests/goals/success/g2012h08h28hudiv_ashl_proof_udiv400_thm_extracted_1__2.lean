
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem udiv400_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(2#32 ≥ ↑32 ∨ 100#32 = 0) → ¬400#32 = 0 → x >>> 2#32 / 100#32 = x / 400#32 :=
sorry