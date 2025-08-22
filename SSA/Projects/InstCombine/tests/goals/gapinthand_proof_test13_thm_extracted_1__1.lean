
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

theorem test13_thm.extracted_1._1 : ∀ (x : BitVec 1024),
  ¬1016#1024 ≥ ↑1024 → x.sshiftRight' 1016#1024 &&& 255#1024 = x >>> 1016#1024 :=
sorry