
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

theorem scalar_i8_signbit_lshr_and_eq_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬x_1 ≥ ↑8 → True ∧ BitVec.ofInt 8 (-128) >>> x_1 <<< x_1 ≠ BitVec.ofInt 8 (-128) ∨ x_1 ≥ ↑8 → False :=
sorry