
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

theorem src_srem_shl_demand_min_signbit_mask_hit_last_demand_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬((536870912#32 == 0 || 32 != 1 && x == intMin 32 && 536870912#32 == -1) = true ∨ 1#32 ≥ ↑32) →
    (536870912#32 == 0 || 32 != 1 && x == intMin 32 && 536870912#32 == -1) = true ∨
        True ∧ (x.srem 536870912#32 <<< 1#32).sshiftRight' 1#32 ≠ x.srem 536870912#32 ∨ 1#32 ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (x.srem 536870912#32 <<< 1#32 &&& BitVec.ofInt 32 (-1073741822))) PoisonOr.poison :=
sorry