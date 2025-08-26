
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

theorem not_logicalOr_not_op1_thm.extracted_1._5 : ∀ (x x_1 : BitVec 1),
  ¬x_1 = 1#1 → x_1 ^^^ 1#1 = 1#1 → x ^^^ 1#1 ^^^ 1#1 = x :=
sorry