
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

theorem t7_ugt_sgt_neg1_thm.extracted_1._12 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (65535#32 <ᵤ x_2) = 1#1 → ¬ofBool (-1#32 <ₛ x_2) = 1#1 → ofBool (65535#32 <ₛ x_2) = 1#1 → x = x_1 :=
sorry