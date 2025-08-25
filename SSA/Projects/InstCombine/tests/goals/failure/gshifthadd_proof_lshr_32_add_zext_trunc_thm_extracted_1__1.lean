
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_32_add_zext_trunc_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬32#64 ≥ ↑64 →
    truncate 32 (zeroExtend 64 x_1 + zeroExtend 64 x) + truncate 32 ((zeroExtend 64 x_1 + zeroExtend 64 x) >>> 32#64) =
      x_1 + x + zeroExtend 32 (ofBool (x_1 + x <ᵤ x_1)) :=
sorry