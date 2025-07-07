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

theorem t0_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x.smod (BitVec.ofInt 8 (-32)) ≠ 0 ∨
        (BitVec.ofInt 8 (-32) == 0 || 8 != 1 && x == intMin 8 && BitVec.ofInt 8 (-32) == -1) = true) →
    True ∧ x >>> 5#8 <<< 5#8 ≠ x ∨ 5#8 ≥ ↑8 ∨ True ∧ (0#8).ssubOverflow (x.sshiftRight' 5#8) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (x.sdiv (BitVec.ofInt 8 (-32)))) PoisonOr.poison :=
sorry