
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

theorem lshr_and_thm.extracted_1._1 : ∀ (x x_1 : BitVec 64),
  ¬((42#64 == 0 || 64 != 1 && x_1 == intMin 64 && 42#64 == -1) = true ∨ 5#64 ≥ ↑64 ∨ 7#64 ≥ ↑64) →
    12#64 ≥ ↑64 ∨ (42#64 == 0 || 64 != 1 && x_1 == intMin 64 && 42#64 == -1) = true ∨ 7#64 ≥ ↑64 → False :=
sorry