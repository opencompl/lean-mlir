
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

theorem icmp_sle9_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ (x <<< 7#8).sshiftRight' 7#8 ≠ x ∨ 7#8 ≥ ↑8) →
    ofBool (x <<< 7#8 ≤ₛ BitVec.ofInt 8 (-128)) = ofBool (x != 0#8) :=
sorry