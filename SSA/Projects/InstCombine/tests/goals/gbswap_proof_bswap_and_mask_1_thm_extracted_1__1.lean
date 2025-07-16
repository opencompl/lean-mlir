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

theorem bswap_and_mask_1_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(40#64 ≥ ↑64 ∨ 56#64 ≥ ↑64) →
    40#64 ≥ ↑64 ∨ 56#64 ≥ ↑64 ∨ True ∧ (x >>> 40#64 &&& 65280#64 &&& x >>> 56#64 != 0) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (x >>> 40#64 &&& 65280#64 ||| x >>> 56#64)) PoisonOr.poison :=
sorry