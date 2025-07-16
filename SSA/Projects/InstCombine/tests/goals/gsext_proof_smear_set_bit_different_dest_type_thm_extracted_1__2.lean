 -- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

theorem smear_set_bit_different_dest_type_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬7#8 ≥ ↑8 →
    ¬(24#32 ≥ ↑32 ∨
          31#32 ≥ ↑32 ∨
            True ∧ signExtend 32 (truncate 16 ((x <<< 24#32).sshiftRight' 31#32)) ≠ (x <<< 24#32).sshiftRight' 31#32) →
      signExtend 16 ((truncate 8 x).sshiftRight' 7#8) = truncate 16 ((x <<< 24#32).sshiftRight' 31#32) :=
sorry