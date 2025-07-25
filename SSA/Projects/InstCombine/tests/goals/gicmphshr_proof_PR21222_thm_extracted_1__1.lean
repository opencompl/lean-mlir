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

theorem PR21222_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → ofBool ((BitVec.ofInt 32 (-93)).sshiftRight' x == BitVec.ofInt 32 (-2)) = ofBool (x == 6#32) :=
sorry