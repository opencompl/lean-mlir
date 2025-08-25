
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

theorem srem2_ashr_mask_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬((2#32 == 0 || 32 != 1 && x == intMin 32 && 2#32 == -1) = true ∨ 31#32 ≥ ↑32) →
    ¬(2#32 == 0 || 32 != 1 && x == intMin 32 && 2#32 == -1) = true →
      (x.srem 2#32).sshiftRight' 31#32 &&& 2#32 = x.srem 2#32 &&& 2#32 :=
sorry