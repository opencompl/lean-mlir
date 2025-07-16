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

theorem reassoc_sub_nuw_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ x.usubOverflow 4#32 = true ∨ True ∧ (x - 4#32).usubOverflow 64#32 = true) →
    x - 4#32 - 64#32 = x + BitVec.ofInt 32 (-68) :=
sorry