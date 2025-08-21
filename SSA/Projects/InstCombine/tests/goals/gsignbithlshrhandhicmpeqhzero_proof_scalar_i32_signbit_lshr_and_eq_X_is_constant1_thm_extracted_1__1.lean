
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

theorem scalar_i32_signbit_lshr_and_eq_X_is_constant1_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 →
    True ∧ BitVec.ofInt 32 (-2147483648) >>> x <<< x ≠ BitVec.ofInt 32 (-2147483648) ∨ x ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (ofBool (BitVec.ofInt 32 (-2147483648) >>> x &&& 12345#32 == 0#32))) PoisonOr.poison :=
sorry