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

theorem main13_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ofBool (truncate 16 x <ₛ 0#16) = 1#1 →
    ¬ofBool (x &&& 32896#32 == 32896#32) = 1#1 → ofBool (truncate 8 x <ₛ 0#8) = 1#1 → 2#32 = 1#32 :=
sorry