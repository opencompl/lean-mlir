
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

theorem pr33078_2_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬4#16 ≥ ↑16 → ¬4#8 ≥ ↑8 → truncate 12 (signExtend 16 x >>> 4#16) = signExtend 12 (x.sshiftRight' 4#8) :=
sorry