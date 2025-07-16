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

theorem test53_thm.extracted_1._1 : ∀ (x : BitVec 32),
  True ∧ (truncate 16 x &&& 7224#16 &&& BitVec.ofInt 16 (-32574) != 0) = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
      @instHRefinementOfRefinement _
        (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
      (PoisonOr.value (zeroExtend 64 ((truncate 16 x ||| BitVec.ofInt 16 (-32574)) &&& BitVec.ofInt 16 (-25350))))
      PoisonOr.poison :=
sorry