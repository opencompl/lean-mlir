
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

theorem test14_thm.extracted_1._1 : ∀ (x : BitVec 35),
  ¬(4#35 ≥ ↑35 ∨ 4#35 ≥ ↑35) → True ∧ (x &&& BitVec.ofInt 35 (-19760) &&& 19744#35 != 0) = true → False :=
sorry