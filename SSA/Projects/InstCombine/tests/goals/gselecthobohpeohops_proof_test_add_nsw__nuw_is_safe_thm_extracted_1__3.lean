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

theorem test_add_nsw__nuw_is_safe_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 2147483647#32 == 2147483647#32) = 1#1 →
    ¬(True ∧ (x &&& 2147483647#32).saddOverflow 1#32 = true) →
      True ∧ (x &&& 2147483647#32).uaddOverflow 1#32 = true →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
          @instHRefinementOfRefinement _
            (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
          (PoisonOr.value ((x &&& 2147483647#32) + 1#32)) PoisonOr.poison :=
sorry