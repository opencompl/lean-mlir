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

theorem shl_add_add_fail_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(2#8 ≥ ↑8 ∨ 2#8 ≥ ↑8) →
    2#8 ≥ ↑8 ∨
        2#8 ≥ ↑8 ∨
          True ∧ (x >>> 2#8).saddOverflow 48#8 = true ∨
            True ∧ (x >>> 2#8).uaddOverflow 48#8 = true ∨ True ∧ (x_1 >>> 2#8).uaddOverflow (x >>> 2#8 + 48#8) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (x_1 >>> 2#8 + (x >>> 2#8 + 48#8))) PoisonOr.poison :=
sorry