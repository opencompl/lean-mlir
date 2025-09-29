
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

theorem zext_nneg_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(True ∧ (x &&& 32767#16).msb = true) →
    zeroExtend 24 (x &&& 32767#16) &&& 8388607#24 = zeroExtend 24 (x &&& 32767#16) :=
sorry