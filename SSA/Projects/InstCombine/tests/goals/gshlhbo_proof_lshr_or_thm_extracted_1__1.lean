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

theorem lshr_or_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬((42#8 == 0 || 8 != 1 && x_1 == intMin 8 && 42#8 == -1) = true ∨ 4#8 ≥ ↑8 ∨ 4#8 ≥ ↑8) →
    (42#8 == 0 || 8 != 1 && x_1 == intMin 8 && 42#8 == -1) = true ∨ 4#8 ≥ ↑8 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value ((x_1.srem 42#8 ||| x >>> 4#8) <<< 4#8)) PoisonOr.poison :=
sorry