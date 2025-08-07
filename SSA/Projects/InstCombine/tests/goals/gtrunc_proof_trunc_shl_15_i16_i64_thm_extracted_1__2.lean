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

theorem trunc_shl_15_i16_i64_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬15#64 ≥ ↑64 → ¬15#16 ≥ ↑16 → truncate 16 (x <<< 15#64) = truncate 16 x <<< 15#16 :=
sorry