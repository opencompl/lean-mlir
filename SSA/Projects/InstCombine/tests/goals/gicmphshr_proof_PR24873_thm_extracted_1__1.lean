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

theorem PR24873_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬x ≥ ↑64 → ofBool ((BitVec.ofInt 64 (-4611686018427387904)).sshiftRight' x == -1#64) = ofBool (61#64 <ᵤ x) :=
sorry