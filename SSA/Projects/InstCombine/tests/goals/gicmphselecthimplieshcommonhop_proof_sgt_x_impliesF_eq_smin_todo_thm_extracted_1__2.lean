
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

theorem sgt_x_impliesF_eq_smin_todo_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ofBool (x <ₛ x_1) = 1#1 → ¬ofBool (x_1 ≤ₛ x) = 1#1 → ofBool (BitVec.ofInt 8 (-128) == x_1) = 0#1 :=
sorry