
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

theorem shl_add_log_may_cause_poison_pr62175_with_nuw_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ 4#8 <<< x >>> x ≠ 4#8 ∨ x ≥ ↑8) → x + 2#8 ≥ ↑8 → False :=
sorry