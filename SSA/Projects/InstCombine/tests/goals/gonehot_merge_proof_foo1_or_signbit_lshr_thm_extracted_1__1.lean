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

theorem foo1_or_signbit_lshr_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ¬(x_2 ≥ ↑32 ∨ x ≥ ↑32) →
    True ∧ 1#32 <<< x_2 >>> x_2 ≠ 1#32 ∨
        x_2 ≥ ↑32 ∨
          True ∧ BitVec.ofInt 32 (-2147483648) >>> x <<< x ≠ BitVec.ofInt 32 (-2147483648) ∨
            x ≥ ↑32 ∨
              True ∧ 1#32 <<< x_2 >>> x_2 ≠ 1#32 ∨
                x_2 ≥ ↑32 ∨ True ∧ BitVec.ofInt 32 (-2147483648) >>> x <<< x ≠ BitVec.ofInt 32 (-2147483648) ∨ x ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value
          (ofBool (1#32 <<< x_2 &&& x_1 != 0#32) &&& ofBool (BitVec.ofInt 32 (-2147483648) >>> x &&& x_1 != 0#32)))
        PoisonOr.poison :=
sorry