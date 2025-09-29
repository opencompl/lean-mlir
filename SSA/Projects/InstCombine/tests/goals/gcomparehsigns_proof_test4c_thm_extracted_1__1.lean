
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

theorem test4c_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(63#64 ≥ ↑64 ∨ 63#64 ≥ ↑64) →
    ofBool (truncate 32 (x.sshiftRight' 63#64 ||| (0#64 - x) >>> 63#64) <ₛ 1#32) = ofBool (x <ₛ 1#64) :=
sorry