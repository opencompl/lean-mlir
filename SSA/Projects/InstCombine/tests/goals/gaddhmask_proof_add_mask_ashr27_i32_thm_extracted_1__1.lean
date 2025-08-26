
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

theorem add_mask_ashr27_i32_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(27#32 ≥ ↑32 ∨ 27#32 ≥ ↑32) →
    27#32 ≥ ↑32 ∨ 27#32 ≥ ↑32 ∨ True ∧ (x.sshiftRight' 27#32 &&& 8#32).saddOverflow (x.sshiftRight' 27#32) = true →
      False :=
sorry