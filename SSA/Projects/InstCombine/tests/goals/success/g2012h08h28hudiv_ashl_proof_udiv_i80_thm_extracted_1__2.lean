
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem udiv_i80_thm.extracted_1._2 : ∀ (x : BitVec 80),
  ¬(2#80 ≥ ↑80 ∨ 100#80 = 0) → ¬400#80 = 0 → x >>> 2#80 / 100#80 = x / 400#80 :=
sorry