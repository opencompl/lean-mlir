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

theorem n9_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬62#64 ≥ ↑64 →
    62#64 ≥ ↑64 ∨
        True ∧ signExtend 64 (truncate 32 (x >>> 62#64)) ≠ x >>> 62#64 ∨
          True ∧ zeroExtend 64 (truncate 32 (x >>> 62#64)) ≠ x >>> 62#64 ∨
            True ∧ (0#32).ssubOverflow (truncate 32 (x >>> 62#64)) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (0#32 - truncate 32 (x >>> 62#64))) PoisonOr.poison :=
sorry