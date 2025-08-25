
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem narrow_source_matching_signbits_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ ((-1#32) <<< (x &&& 7#32)).sshiftRight' (x &&& 7#32) ≠ -1#32 ∨ x &&& 7#32 ≥ ↑32) →
    signExtend 64 (truncate 8 ((-1#32) <<< (x &&& 7#32))) = signExtend 64 ((-1#32) <<< (x &&& 7#32)) :=
sorry