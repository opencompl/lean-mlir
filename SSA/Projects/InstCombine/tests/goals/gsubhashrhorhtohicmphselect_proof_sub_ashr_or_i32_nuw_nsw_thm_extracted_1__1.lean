
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

theorem sub_ashr_or_i32_nuw_nsw_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ x_1.ssubOverflow x = true ∨ True ∧ x_1.usubOverflow x = true ∨ 31#32 ≥ ↑32) →
    ofBool (x_1 <ₛ x) = 1#1 → (x_1 - x).sshiftRight' 31#32 ||| x = -1#32 :=
sorry