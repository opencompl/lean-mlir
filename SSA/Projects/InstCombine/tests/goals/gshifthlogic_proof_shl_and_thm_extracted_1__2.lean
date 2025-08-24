
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

theorem shl_and_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(3#8 ≥ ↑8 ∨ 2#8 ≥ ↑8) → ¬(5#8 ≥ ↑8 ∨ 2#8 ≥ ↑8) → (x_1 <<< 3#8 &&& x) <<< 2#8 = x_1 <<< 5#8 &&& x <<< 2#8 :=
sorry