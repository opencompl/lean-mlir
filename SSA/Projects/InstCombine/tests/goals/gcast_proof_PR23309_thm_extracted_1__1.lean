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

theorem PR23309_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ (x_1 + BitVec.ofInt 32 (-4)).ssubOverflow x = true) →
    truncate 1 (x_1 + BitVec.ofInt 32 (-4) - x) = truncate 1 (x_1 - x) :=
sorry