
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

theorem t10_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ (x_1 <<< x).sshiftRight' x ≠ x_1 ∨
        x ≥ ↑32 ∨ (x_1 == 0 || 32 != 1 && x_1 <<< x == intMin 32 && x_1 == -1) = true) →
    True ∧ (1#32 <<< x).sshiftRight' x ≠ 1#32 ∨ True ∧ 1#32 <<< x >>> x ≠ 1#32 ∨ x ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value ((x_1 <<< x).sdiv x_1)) PoisonOr.poison :=
sorry