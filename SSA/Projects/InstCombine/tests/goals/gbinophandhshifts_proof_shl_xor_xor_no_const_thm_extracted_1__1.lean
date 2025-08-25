
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

theorem shl_xor_xor_no_const_thm.extracted_1._1 : ∀ (x x_1 x_2 x_3 : BitVec 8),
  ¬(x_2 ≥ ↑8 ∨ x_2 ≥ ↑8) →
    x_2 ≥ ↑8 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (x_3 <<< x_2 ^^^ (x_1 <<< x_2 ^^^ x))) PoisonOr.poison :=
sorry