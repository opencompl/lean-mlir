
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

theorem test13_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬zeroExtend 128 x &&& 31#128 ≥ ↑128 →
    True ∧ (x &&& 31#32).msb = true ∨ zeroExtend 64 (x &&& 31#32) ≥ ↑64 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (truncate 64 ((signExtend 128 x_1).sshiftRight' (zeroExtend 128 x &&& 31#128))))
        PoisonOr.poison :=
sorry