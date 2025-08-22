
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

theorem t1_sshr_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(x_1 ≥ ↑32 ∨ True ∧ ((-1#32) <<< x_1 &&& x) >>> x_1 <<< x_1 ≠ (-1#32) <<< x_1 &&& x ∨ x_1 ≥ ↑32) →
    True ∧ ((-1#32) <<< x_1).sshiftRight' x_1 ≠ -1#32 ∨
        x_1 ≥ ↑32 ∨ True ∧ ((-1#32) <<< x_1 &&& x) >>> x_1 <<< x_1 ≠ (-1#32) <<< x_1 &&& x ∨ x_1 ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (((-1#32) <<< x_1 &&& x).sshiftRight' x_1)) PoisonOr.poison :=
sorry