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

theorem pr33078_4_thm.extracted_1._1 : ∀ (x : BitVec 3),
  ¬13#16 ≥ ↑16 →
    13#16 ≥ ↑16 ∨
        True ∧ signExtend 16 (truncate 8 (signExtend 16 x >>> 13#16)) ≠ signExtend 16 x >>> 13#16 ∨
          True ∧ zeroExtend 16 (truncate 8 (signExtend 16 x >>> 13#16)) ≠ signExtend 16 x >>> 13#16 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (truncate 8 (signExtend 16 x >>> 13#16))) PoisonOr.poison :=
sorry