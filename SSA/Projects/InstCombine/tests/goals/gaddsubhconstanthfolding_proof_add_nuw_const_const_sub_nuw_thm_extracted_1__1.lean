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

theorem add_nuw_const_const_sub_nuw_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x.uaddOverflow 1#8 = true ∨ True ∧ (BitVec.ofInt 8 (-127)).usubOverflow (x + 1#8) = true) →
    True ∧ (BitVec.ofInt 8 (-128)).usubOverflow x = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (BitVec.ofInt 8 (-127) - (x + 1#8))) PoisonOr.poison :=
sorry