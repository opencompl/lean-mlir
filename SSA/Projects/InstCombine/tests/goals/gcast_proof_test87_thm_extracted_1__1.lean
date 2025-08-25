
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

theorem test87_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(True ∧ (signExtend 32 x).smulOverflow 16#32 = true ∨ 16#32 ≥ ↑32) →
    12#16 ≥ ↑16 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 16)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (truncate 16 ((signExtend 32 x * 16#32).sshiftRight' 16#32))) PoisonOr.poison :=
sorry