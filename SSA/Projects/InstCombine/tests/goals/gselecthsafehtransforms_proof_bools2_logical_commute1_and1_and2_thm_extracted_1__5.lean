
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

theorem bools2_logical_commute1_and1_and2_thm.extracted_1._5 : ∀ (x x_1 x_2 : BitVec 1),
  ¬x_2 &&& x_1 = 1#1 → x_1 = 1#1 → (x_1 ^^^ 1#1) &&& x = x_2 :=
sorry