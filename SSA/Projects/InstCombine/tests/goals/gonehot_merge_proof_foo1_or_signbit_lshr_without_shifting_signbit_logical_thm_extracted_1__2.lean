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

theorem foo1_or_signbit_lshr_without_shifting_signbit_logical_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ¬x_2 ≥ ↑32 →
    ofBool (1#32 <<< x_2 &&& x_1 != 0#32) = 1#1 →
      ¬x ≥ ↑32 →
        True ∧ 1#32 <<< x_2 >>> x_2 ≠ 1#32 ∨ x_2 ≥ ↑32 →
          HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
            @instHRefinementOfRefinement _
              (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
            (PoisonOr.value (ofBool (x_1 <<< x <ₛ 0#32))) PoisonOr.poison :=
sorry