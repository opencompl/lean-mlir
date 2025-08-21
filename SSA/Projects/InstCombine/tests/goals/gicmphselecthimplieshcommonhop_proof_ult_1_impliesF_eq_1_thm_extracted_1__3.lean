
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

theorem ult_1_impliesF_eq_1_thm.extracted_1._3 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 <ᵤ 1#8) = 1#1 → ofBool (x_1 != 0#8) = 1#1 → ofBool (x_1 == 1#8) = ofBool (x == x_1) :=
sorry