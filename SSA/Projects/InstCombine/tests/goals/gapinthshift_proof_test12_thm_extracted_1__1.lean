
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

theorem test12_thm.extracted_1._1 : ∀ (x : BitVec 47),
  ¬(8#47 ≥ ↑47 ∨ 8#47 ≥ ↑47) → x.sshiftRight' 8#47 <<< 8#47 = x &&& BitVec.ofInt 47 (-256) :=
sorry