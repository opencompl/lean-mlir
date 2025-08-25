
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shift_no_xor_multiuse_cmp_with_xor_thm.extracted_1._6 : ∀ (x x_1 x_2 x_3 : BitVec 32),
  ofBool (x_3 &&& 1#32 == 0#32) = 1#1 →
    ¬(True ∧ ((x_3 &&& 1#32) <<< 1#32).sshiftRight' 1#32 ≠ x_3 &&& 1#32 ∨
          True ∧ (x_3 &&& 1#32) <<< 1#32 >>> 1#32 ≠ x_3 &&& 1#32 ∨ 1#32 ≥ ↑32) →
      x_2 * x_1 = (x_2 ^^^ (x_3 &&& 1#32) <<< 1#32) * x_1 :=
sorry