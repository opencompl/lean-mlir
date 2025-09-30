
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

theorem sub_ashr_and_i8_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ x_1.ssubOverflow x = true ∨ 7#8 ≥ ↑8) → ¬ofBool (x_1 <ₛ x) = 1#1 → (x_1 - x).sshiftRight' 7#8 &&& x = 0#8 :=
sorry