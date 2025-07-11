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

theorem test22_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(2147483647#32 == 0 || 32 != 1 && x &&& 2147483647#32 == intMin 32 && 2147483647#32 == -1) = true →
    2147483647#32 = 0 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value ((x &&& 2147483647#32).srem 2147483647#32)) PoisonOr.poison :=
sorry