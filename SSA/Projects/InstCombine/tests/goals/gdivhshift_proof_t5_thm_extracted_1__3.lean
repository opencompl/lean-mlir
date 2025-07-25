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

theorem t5_thm.extracted_1._3 : ∀ (x : BitVec 1) (x_1 : BitVec 32),
  ¬(x = 1#1 ∨ x_1 ≥ ↑32) → ¬x = 1#1 → ¬1#32 <<< x_1 = 0 → ¬x_1 ≥ ↑32 → x_1 / 1#32 <<< x_1 = x_1 >>> x_1 :=
sorry