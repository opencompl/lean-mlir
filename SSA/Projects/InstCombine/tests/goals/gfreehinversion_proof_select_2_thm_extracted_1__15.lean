
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

theorem select_2_thm.extracted_1._15 : ∀ (x x_1 x_2 : BitVec 8) (x_3 x_4 : BitVec 1),
  x_4 = 1#1 → ¬x_3 = 1#1 → x_1 ^^^ 123#8 ^^^ -1#8 = x_1 ^^^ BitVec.ofInt 8 (-124) :=
sorry