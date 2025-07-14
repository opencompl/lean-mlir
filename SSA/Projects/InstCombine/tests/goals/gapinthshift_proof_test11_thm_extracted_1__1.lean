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

theorem test11_thm.extracted_1._1 : ∀ (x : BitVec 23),
  ¬(11#23 ≥ ↑23 ∨ 12#23 ≥ ↑23) → (x * 3#23) >>> 11#23 <<< 12#23 = x * 6#23 &&& BitVec.ofInt 23 (-4096) :=
sorry