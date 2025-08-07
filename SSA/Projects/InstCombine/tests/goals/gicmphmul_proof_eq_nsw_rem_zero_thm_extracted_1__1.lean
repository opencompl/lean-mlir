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

theorem eq_nsw_rem_zero_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x.smulOverflow (BitVec.ofInt 8 (-5)) = true) →
    ofBool (x * BitVec.ofInt 8 (-5) == 20#8) = ofBool (x == BitVec.ofInt 8 (-4)) :=
sorry