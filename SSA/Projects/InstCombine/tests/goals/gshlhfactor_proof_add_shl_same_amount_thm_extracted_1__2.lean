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

theorem add_shl_same_amount_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 6),
  ¬(x_1 ≥ ↑6 ∨ x_1 ≥ ↑6) → ¬x_1 ≥ ↑6 → x_2 <<< x_1 + x <<< x_1 = (x_2 + x) <<< x_1 :=
sorry