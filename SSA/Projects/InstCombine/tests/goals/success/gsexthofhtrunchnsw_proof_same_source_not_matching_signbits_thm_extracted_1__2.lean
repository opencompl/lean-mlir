
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem same_source_not_matching_signbits_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ ((-1#32) <<< (x &&& 8#32)).sshiftRight' (x &&& 8#32) ≠ -1#32 ∨ x &&& 8#32 ≥ ↑32) →
    ¬(x &&& 8#32 ≥ ↑32 ∨
          True ∧
              BitVec.ofInt 32 (-16777216) <<< (x &&& 8#32) >>> 24#32 <<< 24#32 ≠
                BitVec.ofInt 32 (-16777216) <<< (x &&& 8#32) ∨
            24#32 ≥ ↑32) →
      signExtend 32 (truncate 8 ((-1#32) <<< (x &&& 8#32))) =
        (BitVec.ofInt 32 (-16777216) <<< (x &&& 8#32)).sshiftRight' 24#32 :=
sorry