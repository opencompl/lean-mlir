
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

theorem icmp_power2_and_icmp_shifted_mask_swapped_2147483648_805306368_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 805306368#32 != 805306368#32) &&& ofBool (x <ᵤ 1073741824#32) = ofBool (x <ᵤ 805306368#32) :=
sorry