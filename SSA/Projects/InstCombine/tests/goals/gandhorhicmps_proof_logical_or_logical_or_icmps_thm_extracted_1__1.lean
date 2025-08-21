
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

theorem logical_or_logical_or_icmps_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 8),
  ¬ofBool (x_2 == 42#8) = 1#1 →
    ¬x ≥ ↑8 →
      True ∧ 1#8 <<< x >>> x ≠ 1#8 ∨ x ≥ ↑8 →
        ¬ofBool (x_1 &&& 1#8 == 0#8) = 1#1 →
          HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
            @instHRefinementOfRefinement _
              (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
            (PoisonOr.value (ofBool (x_1 &&& 1#8 <<< x == 0#8))) PoisonOr.poison :=
sorry