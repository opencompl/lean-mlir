
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

theorem n15_variable_shamts_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32) (x_2 x_3 : BitVec 64),
  ¬(x_2 ≥ ↑64 ∨ x ≥ ↑32) → x ≥ ↑32 ∨ x_2 ≥ ↑64 → False :=
sorry