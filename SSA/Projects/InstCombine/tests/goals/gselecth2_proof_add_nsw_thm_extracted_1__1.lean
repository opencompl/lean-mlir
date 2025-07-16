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

theorem add_nsw_thm.extracted_1._1 : ∀ (x : BitVec 1),
  ¬x = 1#1 → ¬(True ∧ (7#8).saddOverflow 64#8 = true) → 7#8 + 64#8 = 71#8 :=
sorry