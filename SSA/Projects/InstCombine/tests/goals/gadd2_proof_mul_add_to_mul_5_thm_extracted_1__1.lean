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

theorem mul_add_to_mul_5_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(True ∧ x.smulOverflow 3#16 = true ∨
        True ∧ x.smulOverflow 7#16 = true ∨ True ∧ (x * 3#16).saddOverflow (x * 7#16) = true) →
    True ∧ x.smulOverflow 10#16 = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 16)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (x * 3#16 + x * 7#16)) PoisonOr.poison :=
sorry