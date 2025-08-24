
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

theorem udiv_exact_ne_30_no_of_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ x_1.umod (x &&& 7#8) ≠ 0 ∨ x &&& 7#8 = 0) →
    True ∧ (x &&& 7#8).umulOverflow 30#8 = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (ofBool (x_1 / (x &&& 7#8) != 30#8))) PoisonOr.poison :=
sorry