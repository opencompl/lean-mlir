
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

theorem and_and_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 2#32 == 0#32) = 1#1 → x &&& 1#32 = zeroExtend 32 (ofBool (x &&& 3#32 != 0#32)) :=
sorry