
/-
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
-/

theorem test14a_thm.extracted_1._1 : ∀ (x : BitVec 79),
  ¬(4#79 ≥ ↑79 ∨ 4#79 ≥ ↑79) → (x <<< 4#79 &&& 1234#79) >>> 4#79 = x &&& 77#79 :=
sorry