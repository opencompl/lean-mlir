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

theorem test_mul__none_are_safe_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x == 805306368#32) = 1#1 → BitVec.ofInt 32 (-1342177280) = x * 9#32 :=
sorry