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

theorem pr33078_3_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬12#16 ≥ ↑16 →
    12#16 ≥ ↑16 ∨ True ∧ zeroExtend 16 (truncate 4 (signExtend 16 x >>> 12#16)) ≠ signExtend 16 x >>> 12#16 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 4)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (truncate 4 (signExtend 16 x >>> 12#16))) PoisonOr.poison :=
sorry