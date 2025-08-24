
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

theorem shl_and_and_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(4#8 ≥ ↑8 ∨ 4#8 ≥ ↑8) → ¬4#8 ≥ ↑8 → x_1 <<< 4#8 &&& (x <<< 4#8 &&& 88#8) = (x &&& x_1) <<< 4#8 &&& 80#8 :=
sorry