
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t3_const_after_fold_lshr_shl_ne_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ¬(32#32 - x_1 ≥ ↑32 ∨ x_1 + -1#32 ≥ ↑32) →
    ¬31#32 ≥ ↑32 →
      ofBool (x_2 >>> (32#32 - x_1) &&& x <<< (x_1 + -1#32) != 0#32) = ofBool (x_2 >>> 31#32 &&& x != 0#32) :=
sorry