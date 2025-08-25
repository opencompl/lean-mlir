
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem wide_source_matching_signbits_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ ((-1#32) <<< (x &&& 7#32)).sshiftRight' (x &&& 7#32) ≠ -1#32 ∨ x &&& 7#32 ≥ ↑32) →
    ¬(True ∧ ((-1#32) <<< (x &&& 7#32)).sshiftRight' (x &&& 7#32) ≠ -1#32 ∨
          x &&& 7#32 ≥ ↑32 ∨ True ∧ signExtend 32 (truncate 24 ((-1#32) <<< (x &&& 7#32))) ≠ (-1#32) <<< (x &&& 7#32)) →
      signExtend 24 (truncate 8 ((-1#32) <<< (x &&& 7#32))) = truncate 24 ((-1#32) <<< (x &&& 7#32)) :=
sorry