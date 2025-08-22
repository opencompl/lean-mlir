
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

theorem ashr_mul_sign_bits_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬3#32 ≥ ↑32 →
    True ∧ (signExtend 16 x_1).smulOverflow (signExtend 16 x) = true ∨ 3#16 ≥ ↑16 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 16)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (truncate 16 ((signExtend 32 x_1 * signExtend 32 x).sshiftRight' 3#32))) PoisonOr.poison :=
sorry