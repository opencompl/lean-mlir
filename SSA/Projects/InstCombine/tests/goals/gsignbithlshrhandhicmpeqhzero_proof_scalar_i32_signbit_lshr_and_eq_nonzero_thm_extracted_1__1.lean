
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

theorem scalar_i32_signbit_lshr_and_eq_nonzero_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬x_1 ≥ ↑32 →
    True ∧ BitVec.ofInt 32 (-2147483648) >>> x_1 <<< x_1 ≠ BitVec.ofInt 32 (-2147483648) ∨ x_1 ≥ ↑32 → False :=
sorry