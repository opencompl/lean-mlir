
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
import SSA.Projects.InstCombine.TacticAuto
import LeanMLIR.Dialects.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false
-/

theorem fold_ne_rhs_fail_shift_not_1s_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬x ≥ ↑8 →
    ofBool ((x_1 ^^^ 123#8) &&& BitVec.ofInt 8 (-2) <<< x != 0#8) =
      ofBool ((x_1 ^^^ 122#8) &&& BitVec.ofInt 8 (-2) <<< x != 0#8) :=
sorry