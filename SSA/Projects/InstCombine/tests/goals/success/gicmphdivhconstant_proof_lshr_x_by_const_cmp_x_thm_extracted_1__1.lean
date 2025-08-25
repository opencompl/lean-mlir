
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_x_by_const_cmp_x_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬1#32 ≥ ↑32 → ofBool (x >>> 1#32 == x) = ofBool (x == 0#32) :=
sorry