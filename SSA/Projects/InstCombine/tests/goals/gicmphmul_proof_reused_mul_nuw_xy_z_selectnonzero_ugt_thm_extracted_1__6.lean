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

theorem reused_mul_nuw_xy_z_selectnonzero_ugt_thm.extracted_1._6 : ∀ (x x_1 x_2 : BitVec 8),
  ¬ofBool (x_2 != 0#8) = 1#1 →
    ¬ofBool (x_2 == 0#8) = 1#1 →
      True ∧ x_1.umulOverflow x_2 = true ∨ True ∧ x.umulOverflow x_2 = true →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
          @instHRefinementOfRefinement _
            (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
          (PoisonOr.value 1#1) PoisonOr.poison :=
sorry