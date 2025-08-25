
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

theorem ashr_sub_nsw_thm.extracted_1._1 : ∀ (x x_1 : BitVec 17),
  ¬(True ∧ x_1.ssubOverflow x = true ∨ 16#17 ≥ ↑17) →
    (x_1 - x).sshiftRight' 16#17 = signExtend 17 (ofBool (x_1 <ₛ x)) :=
sorry