
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

theorem C0zero_thm.extracted_1._4 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 + 10#8 <ᵤ 0#8) = 1#1 →
    ¬ofBool (x_1 <ₛ BitVec.ofInt 8 (-10)) = 1#1 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value x_1) PoisonOr.poison :=
sorry