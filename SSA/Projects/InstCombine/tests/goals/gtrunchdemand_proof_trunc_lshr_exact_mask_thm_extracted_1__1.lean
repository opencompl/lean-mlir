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

theorem trunc_lshr_exact_mask_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬2#8 ≥ ↑8 →
    2#6 ≥ ↑6 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 6)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (truncate 6 (x >>> 2#8) &&& 15#6)) PoisonOr.poison :=
sorry