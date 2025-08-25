
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem smear_set_bit_different_dest_type_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬7#8 ≥ ↑8 →
    ¬(24#32 ≥ ↑32 ∨
          31#32 ≥ ↑32 ∨
            True ∧ signExtend 32 (truncate 16 ((x <<< 24#32).sshiftRight' 31#32)) ≠ (x <<< 24#32).sshiftRight' 31#32) →
      signExtend 16 ((truncate 8 x).sshiftRight' 7#8) = truncate 16 ((x <<< 24#32).sshiftRight' 31#32) :=
sorry