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

theorem mul_splat_fold_no_nuw_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ x.smulOverflow 65537#32 = true ∨ 16#32 ≥ ↑32) →
    16#32 ≥ ↑32 ∨ True ∧ x.saddOverflow (x >>> 16#32) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value ((x * 65537#32) >>> 16#32)) PoisonOr.poison :=
sorry