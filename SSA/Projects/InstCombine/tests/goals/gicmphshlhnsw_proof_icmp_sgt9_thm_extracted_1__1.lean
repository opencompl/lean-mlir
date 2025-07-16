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

theorem icmp_sgt9_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ (x <<< 7#8).sshiftRight' 7#8 ≠ x ∨ 7#8 ≥ ↑8) →
    ofBool (BitVec.ofInt 8 (-128) <ₛ x <<< 7#8) = ofBool (x == 0#8) :=
sorry