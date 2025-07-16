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

theorem p2_scalar_shifted_urem_by_const_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(x ≥ ↑32 ∨ 3#32 = 0) →
    True ∧ (x_1 &&& 1#32) <<< x >>> x ≠ x_1 &&& 1#32 ∨ x ≥ ↑32 ∨ 3#32 = 0 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (ofBool ((x_1 &&& 1#32) <<< x % 3#32 == 0#32))) PoisonOr.poison :=
sorry