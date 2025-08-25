
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t2_const_lshr_shl_eq_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(1#32 ≥ ↑32 ∨ 1#32 ≥ ↑32) →
    ¬2#32 ≥ ↑32 → ofBool (x_1 <<< 1#32 &&& x >>> 1#32 == 0#32) = ofBool (x >>> 2#32 &&& x_1 == 0#32) :=
sorry