
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_shift_nonnegative_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(2#32 ≥ ↑32 ∨ True ∧ (x >>> 2#32 <<< 3#32).sshiftRight' 3#32 ≠ x >>> 2#32 ∨ 3#32 ≥ ↑32) →
    ofBool (0#32 ≤ₛ x >>> 2#32 <<< 3#32) = 1#1 :=
sorry