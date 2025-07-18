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

theorem pr4917_3_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (4294967295#64 <ᵤ zeroExtend 64 x_1 * zeroExtend 64 x) = 1#1 →
    True ∧ (zeroExtend 64 x_1).umulOverflow (zeroExtend 64 x) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value 111#64) PoisonOr.poison :=
sorry