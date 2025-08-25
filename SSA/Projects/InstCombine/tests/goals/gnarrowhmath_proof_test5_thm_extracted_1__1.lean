
/-
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
-/

theorem test5_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬1#32 ≥ ↑32 →
    1#32 ≥ ↑32 ∨ True ∧ (x.sshiftRight' 1#32).saddOverflow 1073741823#32 = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (signExtend 64 (x.sshiftRight' 1#32) + 1073741823#64)) PoisonOr.poison :=
sorry