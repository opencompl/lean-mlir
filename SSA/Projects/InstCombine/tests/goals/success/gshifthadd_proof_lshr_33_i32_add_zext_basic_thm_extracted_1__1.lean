
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_33_i32_add_zext_basic_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬33#64 ≥ ↑64 → (zeroExtend 64 x_1 + zeroExtend 64 x) >>> 33#64 = 0#64 :=
sorry