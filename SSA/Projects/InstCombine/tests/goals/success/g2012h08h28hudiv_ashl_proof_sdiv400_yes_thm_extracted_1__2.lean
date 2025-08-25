
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sdiv400_yes_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(2#32 ≥ ↑32 ∨ (100#32 == 0 || 32 != 1 && x >>> 2#32 == intMin 32 && 100#32 == -1) = true) →
    ¬400#32 = 0 → (x >>> 2#32).sdiv 100#32 = x / 400#32 :=
sorry