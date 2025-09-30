
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

theorem scalar_i16_signbit_lshr_and_eq_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬x_1 ≥ ↑16 → True ∧ BitVec.ofInt 16 (-32768) >>> x_1 <<< x_1 ≠ BitVec.ofInt 16 (-32768) ∨ x_1 ≥ ↑16 → False :=
sorry