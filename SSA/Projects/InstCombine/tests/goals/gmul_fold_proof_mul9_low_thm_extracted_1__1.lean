
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

theorem mul9_low_thm.extracted_1._1 : ∀ (x x_1 : BitVec 9),
  ¬(4#9 ≥ ↑9 ∨ 4#9 ≥ ↑9 ∨ 4#9 ≥ ↑9) →
    4#9 ≥ ↑9 ∨
        True ∧ (x_1 >>> 4#9).umulOverflow (x &&& 15#9) = true ∨
          4#9 ≥ ↑9 ∨
            True ∧ (x_1 &&& 15#9).umulOverflow (x >>> 4#9) = true ∨
              4#9 ≥ ↑9 ∨
                True ∧ (x_1 &&& 15#9).smulOverflow (x &&& 15#9) = true ∨
                  True ∧ (x_1 &&& 15#9).umulOverflow (x &&& 15#9) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 9)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value
          ((x_1 >>> 4#9 * (x &&& 15#9) + (x_1 &&& 15#9) * x >>> 4#9) <<< 4#9 + (x_1 &&& 15#9) * (x &&& 15#9)))
        PoisonOr.poison :=
sorry