
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

theorem t7_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ (0#8).ssubOverflow x = true) → ofBool (0#8 - x ≤ᵤ x) = ofBool (x <ₛ 1#8) :=
sorry