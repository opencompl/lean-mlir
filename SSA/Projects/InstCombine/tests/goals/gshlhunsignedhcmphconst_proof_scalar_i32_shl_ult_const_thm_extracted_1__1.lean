
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

theorem scalar_i32_shl_ult_const_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬11#32 ≥ ↑32 → ofBool (x <<< 11#32 <ᵤ 131072#32) = ofBool (x &&& 2097088#32 == 0#32) :=
sorry