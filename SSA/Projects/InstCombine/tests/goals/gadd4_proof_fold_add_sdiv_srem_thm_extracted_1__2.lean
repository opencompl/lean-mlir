
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

theorem fold_add_sdiv_srem_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬((10#32 == 0 || 32 != 1 && x == intMin 32 && 10#32 == -1) = true ∨
        4#32 ≥ ↑32 ∨ (10#32 == 0 || 32 != 1 && x == intMin 32 && 10#32 == -1) = true) →
    ¬((10#32 == 0 || 32 != 1 && x == intMin 32 && 10#32 == -1) = true ∨
          True ∧ (x.sdiv 10#32).smulOverflow 6#32 = true) →
      x.sdiv 10#32 <<< 4#32 + x.srem 10#32 = x.sdiv 10#32 * 6#32 + x :=
sorry