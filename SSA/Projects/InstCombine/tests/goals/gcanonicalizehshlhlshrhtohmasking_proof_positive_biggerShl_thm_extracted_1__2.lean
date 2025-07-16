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

theorem positive_biggerShl_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(10#32 ≥ ↑32 ∨ 5#32 ≥ ↑32) → ¬5#32 ≥ ↑32 → x <<< 10#32 >>> 5#32 = x <<< 5#32 &&& 134217696#32 :=
sorry