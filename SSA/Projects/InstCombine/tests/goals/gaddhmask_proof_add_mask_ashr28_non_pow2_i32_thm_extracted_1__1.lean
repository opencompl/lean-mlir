
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

theorem add_mask_ashr28_non_pow2_i32_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(28#32 ≥ ↑32 ∨ 28#32 ≥ ↑32) →
    28#32 ≥ ↑32 ∨ 28#32 ≥ ↑32 ∨ True ∧ (x.sshiftRight' 28#32 &&& 9#32).saddOverflow (x.sshiftRight' 28#32) = true →
      False :=
sorry