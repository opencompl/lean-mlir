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

theorem i_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬((BitVec.ofInt 8 (-3) == 0 || 8 != 1 && x == intMin 8 && BitVec.ofInt 8 (-3) == -1) = true ∨
        (BitVec.ofInt 8 (-3) == 0 || 8 != 1 && x.sdiv (BitVec.ofInt 8 (-3)) == intMin 8 && BitVec.ofInt 8 (-3) == -1) =
          true) →
    (9#8 == 0 || 8 != 1 && x == intMin 8 && 9#8 == -1) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value ((x.sdiv (BitVec.ofInt 8 (-3))).sdiv (BitVec.ofInt 8 (-3)))) PoisonOr.poison :=
sorry