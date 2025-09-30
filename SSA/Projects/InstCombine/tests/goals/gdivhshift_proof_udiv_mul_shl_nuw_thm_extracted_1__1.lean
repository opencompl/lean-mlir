
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

theorem udiv_mul_shl_nuw_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 5),
  ¬(True ∧ x_2.umulOverflow x_1 = true ∨ True ∧ x_2 <<< x >>> x ≠ x_2 ∨ x ≥ ↑5 ∨ x_2 <<< x = 0) → x ≥ ↑5 → False :=
sorry