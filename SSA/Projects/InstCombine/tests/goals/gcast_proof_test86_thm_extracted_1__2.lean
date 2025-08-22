
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

theorem test86_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬4#32 ≥ ↑32 → ¬4#16 ≥ ↑16 → truncate 16 ((signExtend 32 x).sshiftRight' 4#32) = x.sshiftRight' 4#16 :=
sorry