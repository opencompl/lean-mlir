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

theorem pb_thm.extracted_1._1 : ∀ (x : BitVec 65),
  ¬(1#65 ≥ ↑65 ∨ True ∧ x <<< 1#65 >>> 1#65 <<< 1#65 ≠ x <<< 1#65 ∨ 1#65 ≥ ↑65) →
    ofBool (x != (x <<< 1#65).sshiftRight' 1#65) = ofBool (x + 9223372036854775808#65 <ₛ 0#65) :=
sorry