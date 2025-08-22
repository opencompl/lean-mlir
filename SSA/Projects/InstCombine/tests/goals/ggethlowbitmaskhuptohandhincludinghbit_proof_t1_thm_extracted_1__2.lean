
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

theorem t1_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(x ≥ ↑16 ∨ x ≥ ↑16) → ¬15#16 - x ≥ ↑16 → 1#16 <<< x + -1#16 ||| 1#16 <<< x = (-1#16) >>> (15#16 - x) :=
sorry