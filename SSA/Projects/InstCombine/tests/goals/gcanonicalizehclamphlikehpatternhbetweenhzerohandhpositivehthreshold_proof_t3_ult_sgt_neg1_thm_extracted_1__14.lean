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

theorem t3_ult_sgt_neg1_thm.extracted_1._14 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 <ᵤ 65536#32) = 1#1 → ¬ofBool (-1#32 <ₛ x_2) = 1#1 → ofBool (65535#32 <ₛ x_2) = 1#1 → x = x_1 :=
sorry