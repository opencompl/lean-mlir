
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

theorem scalar_i16_shl_ult_const_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬8#16 ≥ ↑16 → ofBool (x <<< 8#16 <ᵤ 1024#16) = ofBool (x &&& 252#16 == 0#16) :=
sorry