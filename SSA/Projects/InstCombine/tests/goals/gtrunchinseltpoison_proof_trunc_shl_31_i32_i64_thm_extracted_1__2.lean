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

theorem trunc_shl_31_i32_i64_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬31#64 ≥ ↑64 → ¬31#32 ≥ ↑32 → truncate 32 (x <<< 31#64) = truncate 32 x <<< 31#32 :=
sorry