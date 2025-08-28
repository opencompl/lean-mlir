
/-
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
-/

theorem test35_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ (0#32 - x &&& 240#32).msb = true) →
    0#64 - zeroExtend 64 x &&& 240#64 = zeroExtend 64 (0#32 - x &&& 240#32) :=
sorry