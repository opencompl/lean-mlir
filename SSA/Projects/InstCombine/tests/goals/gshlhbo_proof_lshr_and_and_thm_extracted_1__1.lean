
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

theorem lshr_and_and_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(2#8 ≥ ↑8 ∨ (42#8 == 0 || 8 != 1 && x == intMin 8 && 42#8 == -1) = true ∨ 2#8 ≥ ↑8) →
    (42#8 == 0 || 8 != 1 && x == intMin 8 && 42#8 == -1) = true ∨ 2#8 ≥ ↑8 → False :=
sorry