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

theorem or_trunc_lshr_more_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬4#8 ≥ ↑8 →
    4#6 ≥ ↑6 ∨ True ∧ (truncate 6 x >>> 4#6 &&& BitVec.ofInt 6 (-4) != 0) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 6)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (truncate 6 (x >>> 4#8) ||| BitVec.ofInt 6 (-4))) PoisonOr.poison :=
sorry