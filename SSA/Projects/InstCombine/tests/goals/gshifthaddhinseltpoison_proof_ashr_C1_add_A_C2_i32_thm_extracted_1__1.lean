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

theorem ashr_C1_add_A_C2_i32_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(x &&& 65535#32) + 5#32 ≥ ↑32 → (6#32).sshiftRight' ((x &&& 65535#32) + 5#32) = 0#32 :=
sorry