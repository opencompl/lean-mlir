
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem splat_mul_unknown_lz_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬95#128 ≥ ↑128 → ofBool ((zeroExtend 128 x * 18446744078004518913#128) >>> 95#128 == 0#128) = ofBool (-1#32 <ₛ x) :=
sorry