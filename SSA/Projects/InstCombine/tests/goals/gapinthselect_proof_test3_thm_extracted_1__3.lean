
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

theorem test3_thm.extracted_1._3 : ∀ (x : BitVec 41),
  ¬ofBool (x <ₛ 0#41) = 1#1 →
    40#41 ≥ ↑41 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 41)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value 0#41) PoisonOr.poison :=
sorry