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

theorem test_sub__nsw_is_safe_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x ||| BitVec.ofInt 32 (-2147483648) == BitVec.ofInt 32 (-2147483647)) = 1#1 →
    True ∧ (BitVec.ofInt 32 (-2147483648)).ssubOverflow (x ||| BitVec.ofInt 32 (-2147483648)) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (-1#32)) PoisonOr.poison :=
sorry