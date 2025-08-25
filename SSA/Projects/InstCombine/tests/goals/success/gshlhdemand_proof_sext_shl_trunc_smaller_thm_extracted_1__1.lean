
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sext_shl_trunc_smaller_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 16),
  ¬x ≥ ↑32 → truncate 5 (signExtend 32 x_1 <<< x) = truncate 5 (zeroExtend 32 x_1 <<< x) :=
sorry