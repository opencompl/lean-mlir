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

theorem t0_thm.extracted_1._4 : ∀ (x : BitVec 8) (x_1 : BitVec 1),
  x_1 ^^^ 1#1 = 1#1 →
    ¬x_1 = 1#1 →
      ¬True →
        0#1 = 1#1 →
          HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
            @instHRefinementOfRefinement _
              (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
            (PoisonOr.value x) PoisonOr.poison :=
sorry