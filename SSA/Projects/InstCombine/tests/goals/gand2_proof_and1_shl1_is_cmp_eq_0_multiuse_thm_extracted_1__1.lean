
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

theorem and1_shl1_is_cmp_eq_0_multiuse_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(x ≥ ↑8 ∨ x ≥ ↑8) →
    True ∧ 1#8 <<< x >>> x ≠ 1#8 ∨
        x ≥ ↑8 ∨ True ∧ 1#8 <<< x >>> x ≠ 1#8 ∨ x ≥ ↑8 ∨ True ∧ (1#8 <<< x).uaddOverflow (1#8 <<< x &&& 1#8) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (1#8 <<< x + (1#8 <<< x &&& 1#8))) PoisonOr.poison :=
sorry