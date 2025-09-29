
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

theorem add_mask_ashr28_i32_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(28#32 ≥ ↑32 ∨ 28#32 ≥ ↑32) →
    ¬28#32 ≥ ↑32 → (x.sshiftRight' 28#32 &&& 8#32) + x.sshiftRight' 28#32 = x >>> 28#32 &&& 7#32 :=
sorry