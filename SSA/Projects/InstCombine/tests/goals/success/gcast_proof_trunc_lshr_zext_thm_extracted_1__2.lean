
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_lshr_zext_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬6#32 ≥ ↑32 → ¬6#8 ≥ ↑8 → truncate 8 (zeroExtend 32 x >>> 6#32) = x >>> 6#8 :=
sorry