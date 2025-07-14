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

theorem test2_thm.extracted_1._2 : ∀ (x : BitVec 49),
  ¬(17#49 ≥ ↑49 ∨ 4096#49 <<< 17#49 = 0) → ¬29#49 ≥ ↑49 → x / 4096#49 <<< 17#49 = x >>> 29#49 :=
sorry