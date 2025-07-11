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

theorem or_test2_thm.extracted_1._1 : ∀ (x : BitVec 7),
  ¬6#7 ≥ ↑7 → x <<< 6#7 ||| BitVec.ofInt 7 (-64) = BitVec.ofInt 7 (-64) :=
sorry