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

theorem narrow_zext_ashr_keep_trunc_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ (signExtend 32 x_1).saddOverflow (signExtend 32 x) = true ∨ 1#32 ≥ ↑32) →
    True ∧ (signExtend 16 x_1).saddOverflow (signExtend 16 x) = true ∨ 1#16 ≥ ↑16 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (truncate 8 ((signExtend 32 x_1 + signExtend 32 x).sshiftRight' 1#32))) PoisonOr.poison :=
sorry