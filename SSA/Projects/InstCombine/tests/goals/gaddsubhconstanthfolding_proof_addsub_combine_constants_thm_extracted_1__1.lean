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

theorem addsub_combine_constants_thm.extracted_1._1 : ∀ (x x_1 : BitVec 7),
  ¬(True ∧ (x_1 + 42#7).saddOverflow (10#7 - x) = true) → x_1 + 42#7 + (10#7 - x) = x_1 - x + 52#7 :=
sorry