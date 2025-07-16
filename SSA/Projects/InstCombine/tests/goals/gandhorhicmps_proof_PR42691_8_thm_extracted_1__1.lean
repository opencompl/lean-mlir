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

theorem PR42691_8_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x <ₛ 14#32) &&& ofBool (x != BitVec.ofInt 32 (-2147483648)) =
    ofBool (x + 2147483647#32 <ᵤ BitVec.ofInt 32 (-2147483635)) :=
sorry