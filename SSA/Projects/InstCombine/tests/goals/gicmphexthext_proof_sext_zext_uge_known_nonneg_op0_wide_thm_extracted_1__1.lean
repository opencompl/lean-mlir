
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

theorem sext_zext_uge_known_nonneg_op0_wide_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 16),
  True ∧ (x &&& 12#8).msb = true → False :=
sorry