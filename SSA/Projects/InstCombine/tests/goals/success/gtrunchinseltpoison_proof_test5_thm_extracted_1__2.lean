
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test5_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬16#128 ≥ ↑128 → ¬16#32 ≥ ↑32 → truncate 32 (zeroExtend 128 x >>> 16#128) = x >>> 16#32 :=
sorry