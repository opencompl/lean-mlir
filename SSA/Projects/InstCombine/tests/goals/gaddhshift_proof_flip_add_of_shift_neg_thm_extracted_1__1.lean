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

theorem flip_add_of_shift_neg_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 8),
  ¬(True ∧ ((0#8 - x_2) <<< x_1).sshiftRight' x_1 ≠ 0#8 - x_2 ∨
        True ∧ (0#8 - x_2) <<< x_1 >>> x_1 ≠ 0#8 - x_2 ∨ x_1 ≥ ↑8) →
    x_1 ≥ ↑8 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value ((0#8 - x_2) <<< x_1 + x)) PoisonOr.poison :=
sorry