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

theorem test2_thm.extracted_1._1 : ∀ (x : BitVec 499),
  ¬(111#499 ≥ ↑499 ∨ 4096#499 <<< 111#499 = 0) →
    x % 4096#499 <<< 111#499 = x &&& 10633823966279326983230456482242756607#499 :=
sorry