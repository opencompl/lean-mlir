
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
import SSA.Projects.InstCombine.TacticAuto
import LeanMLIR.Dialects.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false
-/

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