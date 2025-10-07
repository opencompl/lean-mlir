
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
import SSA.Projects.InstCombine.TacticAuto
import LeanMLIR.Dialects.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false
-/

theorem test16_thm.extracted_1._1 : ∀ (x : BitVec 84),
  ¬4#84 ≥ ↑84 → ofBool (x.sshiftRight' 4#84 &&& 1#84 != 0#84) = ofBool (x &&& 16#84 != 0#84) :=
sorry