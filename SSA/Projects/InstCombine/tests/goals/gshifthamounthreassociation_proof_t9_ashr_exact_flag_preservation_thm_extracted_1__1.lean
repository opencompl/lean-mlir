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

theorem t9_ashr_exact_flag_preservation_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ x_1 >>> (32#32 - x) <<< (32#32 - x) ≠ x_1 ∨
        32#32 - x ≥ ↑32 ∨
          True ∧
              x_1.sshiftRight' (32#32 - x) >>> (x + BitVec.ofInt 32 (-2)) <<< (x + BitVec.ofInt 32 (-2)) ≠
                x_1.sshiftRight' (32#32 - x) ∨
            x + BitVec.ofInt 32 (-2) ≥ ↑32) →
    True ∧ x_1 >>> 30#32 <<< 30#32 ≠ x_1 ∨ 30#32 ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value ((x_1.sshiftRight' (32#32 - x)).sshiftRight' (x + BitVec.ofInt 32 (-2)))) PoisonOr.poison :=
sorry