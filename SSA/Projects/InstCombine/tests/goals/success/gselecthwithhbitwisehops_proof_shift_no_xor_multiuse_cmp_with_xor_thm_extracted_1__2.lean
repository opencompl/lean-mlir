
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shift_no_xor_multiuse_cmp_with_xor_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& 1#32 == 0#32) = 1#1 →
    ¬(True ∧ ((x_2 &&& 1#32) <<< 1#32).sshiftRight' 1#32 ≠ x_2 &&& 1#32 ∨
          True ∧ (x_2 &&& 1#32) <<< 1#32 >>> 1#32 ≠ x_2 &&& 1#32 ∨ 1#32 ≥ ↑32) →
      x_1 * x = (x_1 ^^^ (x_2 &&& 1#32) <<< 1#32) * x :=
sorry