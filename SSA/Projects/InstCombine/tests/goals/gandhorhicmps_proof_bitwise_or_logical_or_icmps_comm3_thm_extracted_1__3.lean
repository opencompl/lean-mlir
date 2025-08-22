
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

theorem bitwise_or_logical_or_icmps_comm3_thm.extracted_1._3 : ∀ (x x_1 : BitVec 8),
  ¬x ≥ ↑8 →
    ofBool (x_1 &&& 1#8 == 0#8) = 1#1 →
      ¬(True ∧ 1#8 <<< x >>> x ≠ 1#8 ∨ x ≥ ↑8 ∨ True ∧ 1#8 <<< x >>> x ≠ 1#8 ∨ x ≥ ↑8) →
        ¬ofBool (x_1 &&& (1#8 <<< x ||| 1#8) != 1#8 <<< x ||| 1#8) = 1#1 →
          HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
            @instHRefinementOfRefinement _
              (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
            (PoisonOr.value (ofBool (x_1 &&& 1#8 <<< x == 0#8) ||| 1#1)) PoisonOr.poison :=
sorry