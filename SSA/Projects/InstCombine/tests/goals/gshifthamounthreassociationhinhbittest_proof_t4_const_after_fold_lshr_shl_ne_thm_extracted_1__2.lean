
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

theorem t4_const_after_fold_lshr_shl_ne_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ¬(32#32 - x_1 ≥ ↑32 ∨ x_1 + -1#32 ≥ ↑32) →
    ¬31#32 ≥ ↑32 →
      ofBool (x_2 <<< (32#32 - x_1) &&& x >>> (x_1 + -1#32) != 0#32) = ofBool (x >>> 31#32 &&& x_2 != 0#32) :=
sorry