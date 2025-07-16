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

theorem p0_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(5#8 ≥ ↑8 ∨ True ∧ x <<< 5#8 >>> 5#8 <<< 5#8 ≠ x <<< 5#8 ∨ 5#8 ≥ ↑8) →
    ofBool ((x <<< 5#8).sshiftRight' 5#8 != x) = ofBool (x + BitVec.ofInt 8 (-4) <ᵤ BitVec.ofInt 8 (-8)) :=
sorry