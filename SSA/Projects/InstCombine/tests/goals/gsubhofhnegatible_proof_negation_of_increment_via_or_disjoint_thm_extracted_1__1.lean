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

theorem negation_of_increment_via_or_disjoint_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ (x &&& 1#8 != 0) = true) → x_1 - (x ||| 1#8) = x_1 + (x ^^^ -1#8) :=
sorry