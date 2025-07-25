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

theorem icmp_ult_8_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(True ∧ x <<< 8#64 >>> 8#64 ≠ x ∨ 8#64 ≥ ↑64) → ofBool (x <<< 8#64 <ᵤ 4095#64) = ofBool (x <ᵤ 16#64) :=
sorry