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

theorem src_x_and_nmask_eq_thm.extracted_1._6 : ∀ (x x_1 : BitVec 8) (x_2 : BitVec 1),
  ¬x_2 = 1#1 → x_2 ^^^ 1#1 = 1#1 → ofBool (0#8 == x &&& 0#8) = 1#1 :=
sorry