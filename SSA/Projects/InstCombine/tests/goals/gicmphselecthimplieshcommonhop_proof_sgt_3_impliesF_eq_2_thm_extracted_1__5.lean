
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
import SSA.Projects.InstCombine.TacticAuto
import LeanMLIR.Dialects.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false
-/

theorem sgt_3_impliesF_eq_2_thm.extracted_1._5 : ∀ (x x_1 : BitVec 8),
  ¬ofBool (3#8 <ₛ x_1) = 1#1 → ¬ofBool (x_1 <ₛ 4#8) = 1#1 → ofBool (x == x_1) = 0#1 :=
sorry