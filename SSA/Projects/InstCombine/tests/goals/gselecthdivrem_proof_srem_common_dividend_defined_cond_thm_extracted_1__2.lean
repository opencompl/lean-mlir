
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

theorem srem_common_dividend_defined_cond_thm.extracted_1._2 : ∀ (x x_1 : BitVec 5) (x_2 : BitVec 1),
  ¬(x_2 = 1#1 ∨ (x == 0 || 5 != 1 && x_1 == intMin 5 && x == -1) = true) →
    ¬x_2 = 1#1 →
      (x == 0 || 5 != 1 && x_1 == intMin 5 && x == -1) = true →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 5)) (self :=
          @instHRefinementOfRefinement _
            (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
          (PoisonOr.value (x_1.srem x)) PoisonOr.poison :=
sorry