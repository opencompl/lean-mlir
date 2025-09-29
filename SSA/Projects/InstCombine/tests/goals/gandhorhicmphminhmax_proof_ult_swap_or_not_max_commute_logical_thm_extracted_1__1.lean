
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

theorem ult_swap_or_not_max_commute_logical_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (x != -1#8) = 1#1 → 1#1 = ofBool (x != -1#8) :=
sorry