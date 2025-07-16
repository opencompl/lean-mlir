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

theorem zext_nneg_redundant_and_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x.msb = true) → zeroExtend 32 x &&& 127#32 = zeroExtend 32 x :=
sorry