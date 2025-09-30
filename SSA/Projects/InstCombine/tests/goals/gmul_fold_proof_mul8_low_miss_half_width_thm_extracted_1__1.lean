
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

theorem mul8_low_miss_half_width_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(3#8 ≥ ↑8 ∨ 3#8 ≥ ↑8 ∨ 3#8 ≥ ↑8) →
    3#8 ≥ ↑8 ∨ 3#8 ≥ ↑8 ∨ 3#8 ≥ ↑8 ∨ True ∧ (x_1 &&& 15#8).umulOverflow (x &&& 15#8) = true → False :=
sorry