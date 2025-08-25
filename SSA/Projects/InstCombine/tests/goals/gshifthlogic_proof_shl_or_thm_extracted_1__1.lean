
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

theorem shl_or_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬((42#16 == 0 || 16 != 1 && x_1 == intMin 16 && 42#16 == -1) = true ∨ 5#16 ≥ ↑16 ∨ 7#16 ≥ ↑16) →
    12#16 ≥ ↑16 ∨
        (42#16 == 0 || 16 != 1 && x_1 == intMin 16 && 42#16 == -1) = true ∨
          True ∧ (x_1.srem 42#16 <<< 7#16).sshiftRight' 7#16 ≠ x_1.srem 42#16 ∨ 7#16 ≥ ↑16 →
      False :=
sorry