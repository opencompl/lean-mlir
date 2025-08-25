
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_lshr_thm.extracted_1._1 : ∀ (x : BitVec 232),
  ¬(231#232 ≥ ↑232 ∨ 1#232 ≥ ↑232) → x >>> 231#232 >>> 1#232 = 0#232 :=
sorry