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

theorem test_nsw_dropped_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 1073741823#32 == 0#32) = 1#1 →
    ¬(True ∧ (x <<< 2#32).sshiftRight' 2#32 ≠ x ∨ 2#32 ≥ ↑32) →
      2#32 ≥ ↑32 →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
          @instHRefinementOfRefinement _
            (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
          (PoisonOr.value (x <<< 2#32)) PoisonOr.poison :=
sorry