
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_by_const_cmp_sge_value_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬3#32 ≥ ↑32 → ofBool (x ≤ₛ x >>> 3#32) = ofBool (x <ₛ 1#32) :=
sorry