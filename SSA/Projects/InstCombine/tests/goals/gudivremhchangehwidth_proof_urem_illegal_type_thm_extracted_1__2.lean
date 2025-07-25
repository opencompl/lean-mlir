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

theorem urem_illegal_type_thm.extracted_1._2 : ∀ (x x_1 : BitVec 9),
  ¬zeroExtend 32 x = 0 → ¬x = 0 → zeroExtend 32 x_1 % zeroExtend 32 x = zeroExtend 32 (x_1 % x) :=
sorry