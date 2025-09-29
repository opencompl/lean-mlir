
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

theorem not_masked_sub_i8_thm.extracted_1._1 : ∀ (x : BitVec 8),
  True ∧ (11#8).ssubOverflow (x &&& 7#8) = true ∨ True ∧ (11#8).usubOverflow (x &&& 7#8) = true → False :=
sorry