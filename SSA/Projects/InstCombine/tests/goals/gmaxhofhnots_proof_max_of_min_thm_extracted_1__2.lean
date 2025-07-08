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

theorem max_of_min_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (0#32 <ₛ x) = 1#1 → ofBool (-1#32 <ₛ -1#32) = 1#1 ∧ ofBool (0#32 <ₛ x) = 1#1 → x ^^^ -1#32 = -1#32 :=
sorry