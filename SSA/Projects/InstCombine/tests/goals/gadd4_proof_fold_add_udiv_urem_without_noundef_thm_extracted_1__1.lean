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

theorem fold_add_udiv_urem_without_noundef_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(10#32 = 0 ∨ 4#32 ≥ ↑32 ∨ 10#32 = 0) →
    10#32 = 0 ∨ 4#32 ≥ ↑32 ∨ 10#32 = 0 ∨ True ∧ ((x / 10#32) <<< 4#32 &&& x % 10#32 != 0) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value ((x / 10#32) <<< 4#32 + x % 10#32)) PoisonOr.poison :=
sorry