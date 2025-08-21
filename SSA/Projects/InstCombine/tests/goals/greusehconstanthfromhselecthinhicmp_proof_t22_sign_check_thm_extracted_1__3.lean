
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

theorem t22_sign_check_thm.extracted_1._3 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 <ₛ 0#32) = 1#1 → ¬ofBool (-1#32 <ₛ x_1) = 1#1 → x = -1#32 :=
sorry