
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
import SSA.Projects.InstCombine.TacticAuto
import LeanMLIR.Dialects.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false
-/

theorem src_srem_shl_demand_max_mask_hit_demand_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬((4#32 == 0 || 32 != 1 && x == intMin 32 && 4#32 == -1) = true ∨ 1#32 ≥ ↑32) →
    (4#32 == 0 || 32 != 1 && x == intMin 32 && 4#32 == -1) = true ∨
        True ∧ (x.srem 4#32 <<< 1#32).sshiftRight' 1#32 ≠ x.srem 4#32 ∨ 1#32 ≥ ↑32 →
      False :=
sorry