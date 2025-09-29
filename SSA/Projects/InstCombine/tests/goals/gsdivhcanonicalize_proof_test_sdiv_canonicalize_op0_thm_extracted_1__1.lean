
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

theorem test_sdiv_canonicalize_op0_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ (0#32).ssubOverflow x_1 = true ∨ (x == 0 || 32 != 1 && 0#32 - x_1 == intMin 32 && x == -1) = true) →
    (x == 0 || 32 != 1 && x_1 == intMin 32 && x == -1) = true ∨ True ∧ (0#32).ssubOverflow (x_1.sdiv x) = true →
      False :=
sorry