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

theorem test17_thm.extracted_1._1 : ∀ (x : BitVec 106),
  ¬3#106 ≥ ↑106 → ofBool (x >>> 3#106 == 1234#106) = ofBool (x &&& BitVec.ofInt 106 (-8) == 9872#106) :=
sorry