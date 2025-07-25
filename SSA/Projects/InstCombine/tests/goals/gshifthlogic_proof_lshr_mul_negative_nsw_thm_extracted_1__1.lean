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

theorem lshr_mul_negative_nsw_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(True ∧ x.smulOverflow 52#64 = true ∨ 2#64 ≥ ↑64) →
    True ∧ x.smulOverflow 52#64 = true ∨ True ∧ (x * 52#64) >>> 2#64 <<< 2#64 ≠ x * 52#64 ∨ 2#64 ≥ ↑64 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value ((x * 52#64) >>> 2#64)) PoisonOr.poison :=
sorry