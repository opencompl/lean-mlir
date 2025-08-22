
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

theorem t1_ult_slt_0_thm.extracted_1._4 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 <ᵤ 65536#32) = 1#1 →
    ofBool (x_1 <ₛ 0#32) = 1#1 →
      ofBool (65535#32 <ₛ x_1) = 1#1 →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
          @instHRefinementOfRefinement _
            (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
          (PoisonOr.value x) PoisonOr.poison :=
sorry