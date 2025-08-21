
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

theorem test_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 : BitVec 64),
  x = 1#1 →
    4#64 ≥ ↑64 ∨
        3#64 ≥ ↑64 ∨
          True ∧ (x_1 >>> 4#64).saddOverflow (x_1 >>> 3#64) = true ∨
            True ∧ (x_1 >>> 4#64).uaddOverflow (x_1 >>> 3#64) = true →
      ¬(16#64 = 0 ∨ 8#64 = 0) →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
          @instHRefinementOfRefinement _
            (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
          (PoisonOr.value (x_1 / 16#64 + x_1 / 8#64)) PoisonOr.poison :=
sorry