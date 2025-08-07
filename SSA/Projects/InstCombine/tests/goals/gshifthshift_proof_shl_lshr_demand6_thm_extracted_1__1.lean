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

theorem shl_lshr_demand6_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(x ≥ ↑16 ∨ 4#16 ≥ ↑16) →
    x ≥ ↑16 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 16)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (BitVec.ofInt 16 (-32624) <<< x >>> 4#16 &&& 4094#16)) PoisonOr.poison :=
sorry