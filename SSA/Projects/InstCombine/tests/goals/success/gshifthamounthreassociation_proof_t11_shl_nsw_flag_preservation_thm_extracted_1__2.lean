
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t11_shl_nsw_flag_preservation_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ (x_1 <<< (32#32 - x)).sshiftRight' (32#32 - x) ≠ x_1 ∨
        32#32 - x ≥ ↑32 ∨
          True ∧
              (x_1 <<< (32#32 - x) <<< (x + BitVec.ofInt 32 (-2))).sshiftRight' (x + BitVec.ofInt 32 (-2)) ≠
                x_1 <<< (32#32 - x) ∨
            True ∧
                x_1 <<< (32#32 - x) <<< (x + BitVec.ofInt 32 (-2)) >>> (x + BitVec.ofInt 32 (-2)) ≠
                  x_1 <<< (32#32 - x) ∨
              x + BitVec.ofInt 32 (-2) ≥ ↑32) →
    ¬(True ∧ (x_1 <<< 30#32).sshiftRight' 30#32 ≠ x_1 ∨ 30#32 ≥ ↑32) →
      x_1 <<< (32#32 - x) <<< (x + BitVec.ofInt 32 (-2)) = x_1 <<< 30#32 :=
sorry