
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test34_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬8#32 ≥ ↑32 → ¬8#16 ≥ ↑16 → truncate 16 (zeroExtend 32 x >>> 8#32) = x >>> 8#16 :=
sorry