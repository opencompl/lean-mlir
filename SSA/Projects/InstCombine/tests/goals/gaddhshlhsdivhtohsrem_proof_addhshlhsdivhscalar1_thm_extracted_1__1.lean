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

theorem addhshlhsdivhscalar1_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬((BitVec.ofInt 8 (-64) == 0 || 8 != 1 && x == intMin 8 && BitVec.ofInt 8 (-64) == -1) = true ∨ 6#8 ≥ ↑8) →
    (64#8 == 0 || 8 != 1 && x == intMin 8 && 64#8 == -1) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (x.sdiv (BitVec.ofInt 8 (-64)) <<< 6#8 + x)) PoisonOr.poison :=
sorry