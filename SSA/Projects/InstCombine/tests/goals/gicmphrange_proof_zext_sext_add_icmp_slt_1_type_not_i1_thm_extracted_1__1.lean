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

theorem zext_sext_add_icmp_slt_1_type_not_i1_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 : BitVec 2),
  True ∧ (zeroExtend 8 x_1).saddOverflow (signExtend 8 x) = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
      @instHRefinementOfRefinement _
        (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
      (PoisonOr.value (ofBool (zeroExtend 8 x_1 + signExtend 8 x <ₛ 1#8))) PoisonOr.poison :=
sorry