
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_shl__none_are_safe_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& BitVec.ofInt 32 (-2) == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨
          True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
            zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64) →
      x = x.sshiftRight' (zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8))) :=
sorry