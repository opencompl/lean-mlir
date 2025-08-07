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

theorem trunc_lshr_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬2#8 ≥ ↑8 → ¬2#6 ≥ ↑6 → truncate 6 (x >>> 2#8) &&& 14#6 = truncate 6 x >>> 2#6 &&& 14#6 :=
sorry