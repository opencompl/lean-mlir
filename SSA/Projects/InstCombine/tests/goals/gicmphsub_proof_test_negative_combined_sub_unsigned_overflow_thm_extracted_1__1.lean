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

theorem test_negative_combined_sub_unsigned_overflow_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(True ∧ (10#64).usubOverflow x = true) → ofBool (10#64 - x <ᵤ 11#64) = 1#1 :=
sorry