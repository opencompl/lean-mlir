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

theorem xor_icmp_to_icmp_add_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (3#32 <ₛ x) ^^^ ofBool (x <ₛ 6#32) = ofBool (x + BitVec.ofInt 32 (-6) <ᵤ BitVec.ofInt 32 (-2)) :=
sorry