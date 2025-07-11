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

theorem test_srem_canonicalize_op0_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ (0#32).ssubOverflow x_1 = true ∨ (x == 0 || 32 != 1 && 0#32 - x_1 == intMin 32 && x == -1) = true) →
    (x == 0 || 32 != 1 && x_1 == intMin 32 && x == -1) = true ∨ True ∧ (0#32).ssubOverflow (x_1.srem x) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value ((0#32 - x_1).srem x)) PoisonOr.poison :=
sorry