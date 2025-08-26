
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

theorem icmp_ugt_32_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(True ∧ x <<< 32#64 >>> 32#64 ≠ x ∨ 32#64 ≥ ↑64) → ofBool (4294967295#64 <ᵤ x <<< 32#64) = ofBool (x != 0#64) :=
sorry