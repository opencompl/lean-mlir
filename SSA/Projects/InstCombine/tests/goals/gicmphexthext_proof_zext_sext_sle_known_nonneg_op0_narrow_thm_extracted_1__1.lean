
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

theorem zext_sext_sle_known_nonneg_op0_narrow_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 8),
  True ∧ (x_1 &&& 12#8).msb = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
      @instHRefinementOfRefinement _
        (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
      (PoisonOr.value (ofBool (zeroExtend 32 (x_1 &&& 12#8) ≤ₛ signExtend 32 x))) PoisonOr.poison :=
sorry