
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

theorem shl_lshr_eq_amt_multi_use_thm.extracted_1._1 : ∀ (x : BitVec 44),
  ¬(33#44 ≥ ↑44 ∨ 33#44 ≥ ↑44 ∨ 33#44 ≥ ↑44) →
    33#44 ≥ ↑44 ∨ True ∧ (x <<< 33#44 &&& (x &&& 2047#44) != 0) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 44)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (x <<< 33#44 + x <<< 33#44 >>> 33#44)) PoisonOr.poison :=
sorry