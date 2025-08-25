
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_shl_nsw__nuw_is_safe_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 1073741822#32 == 0#32) = 1#1 →
    ¬(True ∧ ((x_1 &&& 1073741822#32) <<< 2#32).sshiftRight' 2#32 ≠ x_1 &&& 1073741822#32 ∨
          2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 1073741822#32) <<< 2#32) ≥ ↑64) →
      ¬(2#32 ≥ ↑32 ∨
            True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
              zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64) →
        x.sshiftRight' (zeroExtend 64 ((x_1 &&& 1073741822#32) <<< 2#32)) =
          x.sshiftRight' (zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8))) :=
sorry