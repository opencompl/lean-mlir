
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

theorem test4_thm.extracted_1._2 : ∀ (x : BitVec 1023),
  ofBool (x <ₛ 0#1023) = 1#1 → ¬1022#1023 ≥ ↑1023 → -1#1023 = x.sshiftRight' 1022#1023 :=
sorry