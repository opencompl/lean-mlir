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

theorem bool_add_ashr_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  ¬1#2 ≥ ↑2 →
    True ∧ (zeroExtend 2 x_1).uaddOverflow (zeroExtend 2 x) = true ∨ 1#2 ≥ ↑2 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 2)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value ((zeroExtend 2 x_1 + zeroExtend 2 x).sshiftRight' 1#2)) PoisonOr.poison :=
sorry