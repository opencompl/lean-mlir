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

theorem twoway_clamp_lt_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬ofBool (x <ₛ 13768#32) = 1#1 →
    ¬ofBool (13767#32 <ₛ x) = 1#1 → ofBool (13767#32 <ₛ 13768#32) = 1#1 → 13768#32 = 13767#32 :=
sorry