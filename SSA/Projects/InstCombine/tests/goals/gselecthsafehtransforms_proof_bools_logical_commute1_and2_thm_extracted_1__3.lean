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

theorem bools_logical_commute1_and2_thm.extracted_1._3 : ∀ (x x_1 : BitVec 1),
  x_1 = 1#1 → ¬x = 1#1 → x ^^^ 1#1 = 1#1 → 1#1 = x_1 :=
sorry