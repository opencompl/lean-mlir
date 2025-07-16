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

theorem urem_illegal_type_c_thm.extracted_1._2 : ∀ (x : BitVec 9),
  ¬10#32 = 0 → ¬(10#9 = 0 ∨ True ∧ (x % 10#9).msb = true) → zeroExtend 32 x % 10#32 = zeroExtend 32 (x % 10#9) :=
sorry