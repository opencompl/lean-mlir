
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

theorem ult_swap_and_not_max_logical_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬ofBool (x <ᵤ x_1) = 1#1 → 0#1 = ofBool (x <ᵤ x_1) :=
sorry