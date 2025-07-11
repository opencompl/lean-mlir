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

theorem trunc_ashr_trunc_outofrange_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬25#32 ≥ ↑32 →
    25#32 ≥ ↑32 ∨
        True ∧ signExtend 32 (truncate 8 ((truncate 32 x).sshiftRight' 25#32)) ≠ (truncate 32 x).sshiftRight' 25#32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (truncate 8 ((truncate 32 x).sshiftRight' 25#32))) PoisonOr.poison :=
sorry