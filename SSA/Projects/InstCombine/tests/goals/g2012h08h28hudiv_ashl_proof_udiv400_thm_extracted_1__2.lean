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

theorem udiv400_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(2#32 ≥ ↑32 ∨ 100#32 = 0) → ¬400#32 = 0 → x >>> 2#32 / 100#32 = x / 400#32 :=
sorry