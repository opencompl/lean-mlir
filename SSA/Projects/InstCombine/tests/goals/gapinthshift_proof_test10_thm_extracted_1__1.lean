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

theorem test10_thm.extracted_1._1 : ∀ (x : BitVec 19),
  ¬(18#19 ≥ ↑19 ∨ 18#19 ≥ ↑19) → x >>> 18#19 <<< 18#19 = x &&& BitVec.ofInt 19 (-262144) :=
sorry