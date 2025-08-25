
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem splat_mul_known_lz_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬96#128 ≥ ↑128 → ofBool ((zeroExtend 128 x * 18446744078004518913#128) >>> 96#128 == 0#128) = 1#1 :=
sorry