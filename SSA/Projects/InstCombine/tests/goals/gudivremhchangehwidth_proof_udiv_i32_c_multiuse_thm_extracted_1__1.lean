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

theorem udiv_i32_c_multiuse_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬10#32 = 0 →
    10#32 = 0 ∨
        True ∧ (zeroExtend 32 x / 10#32).saddOverflow (zeroExtend 32 x) = true ∨
          True ∧ (zeroExtend 32 x / 10#32).uaddOverflow (zeroExtend 32 x) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (zeroExtend 32 x + zeroExtend 32 x / 10#32)) PoisonOr.poison :=
sorry