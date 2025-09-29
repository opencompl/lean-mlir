
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

theorem n11_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  ¬(zeroExtend 32 (30#16 - x) ≥ ↑32 ∨ x + BitVec.ofInt 16 (-31) ≥ ↑16) →
    True ∧ (30#16 - x).msb = true ∨ zeroExtend 32 (30#16 - x) ≥ ↑32 ∨ x + BitVec.ofInt 16 (-31) ≥ ↑16 → False :=
sorry