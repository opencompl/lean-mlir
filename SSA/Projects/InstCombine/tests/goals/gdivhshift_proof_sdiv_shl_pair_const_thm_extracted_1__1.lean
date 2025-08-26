
/-
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
-/

theorem sdiv_shl_pair_const_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ (x <<< 2#32).sshiftRight' 2#32 ≠ x ∨
        2#32 ≥ ↑32 ∨
          True ∧ (x <<< 1#32).sshiftRight' 1#32 ≠ x ∨
            1#32 ≥ ↑32 ∨ (x <<< 1#32 == 0 || 32 != 1 && x <<< 2#32 == intMin 32 && x <<< 1#32 == -1) = true) →
    (x <<< 2#32).sdiv (x <<< 1#32) = 2#32 :=
sorry