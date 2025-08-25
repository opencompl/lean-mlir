
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

theorem ashr_mul_times_3_div_2_exact_2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ x.smulOverflow 3#32 = true ∨ True ∧ (x * 3#32) >>> 1#32 <<< 1#32 ≠ x * 3#32 ∨ 1#32 ≥ ↑32) →
    True ∧ x >>> 1#32 <<< 1#32 ≠ x ∨ 1#32 ≥ ↑32 ∨ True ∧ x.saddOverflow (x.sshiftRight' 1#32) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value ((x * 3#32).sshiftRight' 1#32)) PoisonOr.poison :=
sorry