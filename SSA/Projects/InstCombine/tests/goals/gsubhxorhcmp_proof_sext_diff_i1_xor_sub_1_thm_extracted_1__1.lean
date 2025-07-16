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

theorem sext_diff_i1_xor_sub_1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  True ∧ (zeroExtend 64 x).saddOverflow (signExtend 64 x_1) = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
      @instHRefinementOfRefinement _
        (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
      (PoisonOr.value (signExtend 64 x_1 - signExtend 64 x)) PoisonOr.poison :=
sorry