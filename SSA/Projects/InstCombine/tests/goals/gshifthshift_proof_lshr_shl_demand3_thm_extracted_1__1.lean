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

theorem lshr_shl_demand3_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(x ≥ ↑8 ∨ 3#8 ≥ ↑8) →
    x ≥ ↑8 ∨
        True ∧ 28#8 >>> x <<< 3#8 >>> 3#8 ≠ 28#8 >>> x ∨ 3#8 ≥ ↑8 ∨ True ∧ (28#8 >>> x <<< 3#8 &&& 3#8 != 0) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (28#8 >>> x <<< 3#8 ||| 3#8)) PoisonOr.poison :=
sorry