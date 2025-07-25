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

theorem trunc_sandwich_max_sum_shift2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(30#32 ≥ ↑32 ∨ 1#12 ≥ ↑12) →
    31#32 ≥ ↑32 ∨
        True ∧ signExtend 32 (truncate 12 (x >>> 31#32)) ≠ x >>> 31#32 ∨
          True ∧ zeroExtend 32 (truncate 12 (x >>> 31#32)) ≠ x >>> 31#32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 12)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (truncate 12 (x >>> 30#32) >>> 1#12)) PoisonOr.poison :=
sorry