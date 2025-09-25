
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

theorem sgt_and_min_thm.extracted_1._1 : ∀ (x x_1 : BitVec 9),
  ofBool (x <ₛ x_1) &&& ofBool (x_1 == BitVec.ofInt 9 (-256)) = 0#1 :=
sorry