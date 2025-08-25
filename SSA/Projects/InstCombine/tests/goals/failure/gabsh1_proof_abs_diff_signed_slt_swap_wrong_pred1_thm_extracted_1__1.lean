
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

theorem abs_diff_signed_slt_swap_wrong_pred1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 == x) = 1#1 → ¬(True ∧ x.ssubOverflow x_1 = true) → True ∧ x_1.ssubOverflow x = true → False :=
sorry