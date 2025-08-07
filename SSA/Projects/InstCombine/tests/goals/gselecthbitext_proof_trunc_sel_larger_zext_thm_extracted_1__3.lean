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

theorem trunc_sel_larger_zext_thm.extracted_1._3 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  x_1 = 1#1 → ¬(True ∧ (x &&& 65535#32).msb = true) → zeroExtend 64 (truncate 16 x) = zeroExtend 64 (x &&& 65535#32) :=
sorry