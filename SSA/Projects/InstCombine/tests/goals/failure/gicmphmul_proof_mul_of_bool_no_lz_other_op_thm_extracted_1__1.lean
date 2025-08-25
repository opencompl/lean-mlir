
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul_of_bool_no_lz_other_op_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  ¬(True ∧ (x_1 &&& 1#32).smulOverflow (signExtend 32 x) = true ∨
        True ∧ (x_1 &&& 1#32).umulOverflow (signExtend 32 x) = true) →
    ofBool (127#32 <ₛ (x_1 &&& 1#32) * signExtend 32 x) = 0#1 :=
sorry