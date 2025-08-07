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

theorem ashr_lshr2_i128_thm.extracted_1._2 : ∀ (x x_1 : BitVec 128),
  ¬ofBool (5#128 <ₛ x_1) = 1#1 →
    ¬(True ∧ x_1 >>> x <<< x ≠ x_1 ∨ x ≥ ↑128) →
      x ≥ ↑128 →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 128)) (self :=
          @instHRefinementOfRefinement _
            (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
          (PoisonOr.value (x_1.sshiftRight' x)) PoisonOr.poison :=
sorry