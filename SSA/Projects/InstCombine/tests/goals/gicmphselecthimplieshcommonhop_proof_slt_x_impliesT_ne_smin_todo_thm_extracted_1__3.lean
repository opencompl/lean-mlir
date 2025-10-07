
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

theorem slt_x_impliesT_ne_smin_todo_thm.extracted_1._3 : ∀ (x x_1 x_2 : BitVec 8),
  ¬ofBool (x_2 <ₛ x_1) = 1#1 → ofBool (x_2 != x) = ofBool (x != x_2) :=
sorry