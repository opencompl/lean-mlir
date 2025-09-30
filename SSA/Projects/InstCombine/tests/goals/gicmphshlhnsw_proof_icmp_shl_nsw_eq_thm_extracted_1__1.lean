
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

theorem icmp_shl_nsw_eq_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ (x <<< 5#32).sshiftRight' 5#32 ≠ x ∨ 5#32 ≥ ↑32) → ofBool (x <<< 5#32 == 0#32) = ofBool (x == 0#32) :=
sorry