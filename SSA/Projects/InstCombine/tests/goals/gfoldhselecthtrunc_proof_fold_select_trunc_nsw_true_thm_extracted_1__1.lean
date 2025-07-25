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

theorem fold_select_trunc_nsw_true_thm.extracted_1._1 : ∀ (x : BitVec 128),
  ¬(True ∧ signExtend 128 (truncate 1 x) ≠ x) → truncate 1 x = 1#1 → x = -1#128 :=
sorry