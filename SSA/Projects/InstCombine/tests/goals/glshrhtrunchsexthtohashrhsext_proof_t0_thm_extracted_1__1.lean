
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

theorem t0_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬4#8 ≥ ↑8 → signExtend 16 (truncate 4 (x >>> 4#8)) = signExtend 16 (x.sshiftRight' 4#8) :=
sorry