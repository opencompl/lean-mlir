
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

theorem shl_bad_sub_i64_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬67#64 - x ≥ ↑64 → True ∧ 1#64 <<< (67#64 - x) >>> (67#64 - x) ≠ 1#64 ∨ 67#64 - x ≥ ↑64 → False :=
sorry