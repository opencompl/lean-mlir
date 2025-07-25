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

theorem lshr_mul_times_5_div_4_exact_2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ x.umulOverflow 5#32 = true ∨ True ∧ (x * 5#32) >>> 2#32 <<< 2#32 ≠ x * 5#32 ∨ 2#32 ≥ ↑32) →
    True ∧ x >>> 2#32 <<< 2#32 ≠ x ∨ 2#32 ≥ ↑32 ∨ True ∧ x.uaddOverflow (x >>> 2#32) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value ((x * 5#32) >>> 2#32)) PoisonOr.poison :=
sorry