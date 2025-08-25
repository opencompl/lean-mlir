
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_2_add_zext_basic_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  ¬1#2 ≥ ↑2 → (zeroExtend 2 x_1 + zeroExtend 2 x) >>> 1#2 = zeroExtend 2 (x_1 &&& x) :=
sorry