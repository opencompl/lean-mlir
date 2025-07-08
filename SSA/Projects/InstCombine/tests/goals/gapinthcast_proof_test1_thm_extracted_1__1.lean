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

theorem test1_thm.extracted_1._1 : ∀ (x : BitVec 17),
  ¬(8#37 ≥ ↑37 ∨ 8#37 ≥ ↑37) →
    8#17 ≥ ↑17 ∨ 8#17 ≥ ↑17 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 17)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (truncate 17 (zeroExtend 37 x >>> 8#37 ||| zeroExtend 37 x <<< 8#37))) PoisonOr.poison :=
sorry