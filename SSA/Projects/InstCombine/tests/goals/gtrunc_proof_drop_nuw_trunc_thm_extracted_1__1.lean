
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

theorem drop_nuw_trunc_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬(True ∧ zeroExtend 16 (truncate 8 (x_1 &&& 255#16 &&& x)) ≠ x_1 &&& 255#16 &&& x) →
    truncate 8 (x_1 &&& 255#16 &&& x) = truncate 8 (x_1 &&& x) :=
sorry