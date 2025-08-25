
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t1_const_shl_lshr_ne_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(1#32 ≥ ↑32 ∨ 1#32 ≥ ↑32) →
    ¬2#32 ≥ ↑32 → ofBool (x_1 >>> 1#32 &&& x <<< 1#32 != 0#32) = ofBool (x_1 >>> 2#32 &&& x != 0#32) :=
sorry