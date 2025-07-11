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

theorem shl_or_commuted_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(x + 1#8 ≥ ↑8 ∨ x ≥ ↑8) → ¬x ≥ ↑8 → 3#8 <<< (x + 1#8) ||| 16#8 <<< x = 22#8 <<< x :=
sorry