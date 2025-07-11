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

theorem test4_thm.extracted_1._2 : ∀ (x : BitVec 1) (x_1 : BitVec 32),
  ¬x = 1#1 → ¬8#32 = 0 → x_1 % 8#32 = x_1 &&& 7#32 :=
sorry