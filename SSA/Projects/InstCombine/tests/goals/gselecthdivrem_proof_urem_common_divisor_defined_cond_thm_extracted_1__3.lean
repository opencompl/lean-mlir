
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

theorem urem_common_divisor_defined_cond_thm.extracted_1._3 : ∀ (x x_1 : BitVec 5) (x_2 : BitVec 1),
  ¬(x_2 = 1#1 ∨ x_1 = 0) →
    ¬x_2 = 1#1 →
      x_1 = 0 →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 5)) (self :=
          @instHRefinementOfRefinement _
            (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
          (PoisonOr.value (x % x_1)) PoisonOr.poison :=
sorry