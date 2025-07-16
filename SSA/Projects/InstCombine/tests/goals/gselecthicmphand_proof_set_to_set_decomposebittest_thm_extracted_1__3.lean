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

theorem set_to_set_decomposebittest_thm.extracted_1._3 : ∀ (x : BitVec 8),
  ¬ofBool (x <ₛ 0#8) = 1#1 →
    True ∧ (x &&& BitVec.ofInt 8 (-128) &&& 3#8 != 0) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value 3#8) PoisonOr.poison :=
sorry