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

theorem trunc_shl_7_i8_i64_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬7#64 ≥ ↑64 → ¬7#8 ≥ ↑8 → truncate 8 (x <<< 7#64) = truncate 8 x <<< 7#8 :=
sorry