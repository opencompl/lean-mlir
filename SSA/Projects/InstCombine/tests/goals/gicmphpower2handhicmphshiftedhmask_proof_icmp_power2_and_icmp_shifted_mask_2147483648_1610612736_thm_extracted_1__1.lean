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

theorem icmp_power2_and_icmp_shifted_mask_2147483648_1610612736_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x <ᵤ BitVec.ofInt 32 (-2147483648)) &&& ofBool (x &&& 1610612736#32 != 1610612736#32) =
    ofBool (x <ᵤ 1610612736#32) :=
sorry