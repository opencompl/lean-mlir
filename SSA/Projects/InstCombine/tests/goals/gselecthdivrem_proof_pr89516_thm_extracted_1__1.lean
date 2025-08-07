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

theorem pr89516_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 <ₛ 0#8) = 1#1 →
    ¬(True ∧ 1#8 <<< x >>> x ≠ 1#8 ∨
          x ≥ ↑8 ∨
            (1#8 <<< x == 0 || 8 != 1 && 1#8 == intMin 8 && 1#8 <<< x == -1) = true ∨
              True ∧ 1#8 <<< x >>> x ≠ 1#8 ∨ x ≥ ↑8 ∨ True ∧ ((1#8).srem (1#8 <<< x)).uaddOverflow (1#8 <<< x) = true) →
      True ∧ 1#8 <<< x >>> x ≠ 1#8 ∨ x ≥ ↑8 ∨ (1#8 <<< x == 0 || 8 != 1 && 1#8 == intMin 8 && 1#8 <<< x == -1) = true →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
          @instHRefinementOfRefinement _
            (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
          (PoisonOr.value ((1#8).srem (1#8 <<< x) + 1#8 <<< x)) PoisonOr.poison :=
sorry