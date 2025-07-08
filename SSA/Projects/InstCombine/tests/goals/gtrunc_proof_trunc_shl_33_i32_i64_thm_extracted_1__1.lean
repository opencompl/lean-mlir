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

theorem trunc_shl_33_i32_i64_thm.extracted_1._1 : ∀ (x : BitVec 64), ¬33#64 ≥ ↑64 → truncate 32 (x <<< 33#64) = 0#32 :=
sorry