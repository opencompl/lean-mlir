
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

theorem udiv_shl_mul_nuw_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 5),
  ¬(True ∧ x_2 <<< x_1 >>> x_1 ≠ x_2 ∨ x_1 ≥ ↑5 ∨ True ∧ x_2.umulOverflow x = true ∨ x_2 * x = 0) →
    True ∧ 1#5 <<< x_1 >>> x_1 ≠ 1#5 ∨ x_1 ≥ ↑5 ∨ x = 0 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 5)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (x_2 <<< x_1 / (x_2 * x))) PoisonOr.poison :=
sorry