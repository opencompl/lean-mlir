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

theorem select_icmp_x_and_8_eq_0_y_xor_8_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ofBool (x_1 &&& 8#32 == 0#32) = 1#1 →
    True ∧ (x_1 &&& 8#32).msb = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value x) PoisonOr.poison :=
sorry