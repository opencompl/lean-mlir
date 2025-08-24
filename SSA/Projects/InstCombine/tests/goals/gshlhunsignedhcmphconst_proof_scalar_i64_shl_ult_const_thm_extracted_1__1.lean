
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

theorem scalar_i64_shl_ult_const_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬25#64 ≥ ↑64 → ofBool (x <<< 25#64 <ᵤ 8589934592#64) = ofBool (x &&& 549755813632#64 == 0#64) :=
sorry