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

theorem test19a_thm.extracted_1._1 : ∀ (x : BitVec 39),
  ¬2#39 ≥ ↑39 → ofBool (x.sshiftRight' 2#39 == -1#39) = ofBool (BitVec.ofInt 39 (-5) <ᵤ x) :=
sorry