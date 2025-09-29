
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

theorem n14_trunc_of_lshr_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32) (x_2 : BitVec 64),
  ¬(zeroExtend 64 (32#32 - x_1) ≥ ↑64 ∨ x_1 + -1#32 ≥ ↑32) →
    ¬(x_1 + -1#32 ≥ ↑32 ∨ True ∧ (32#32 - x_1).msb = true ∨ zeroExtend 64 (32#32 - x_1) ≥ ↑64) →
      ofBool (truncate 32 (x_2 >>> zeroExtend 64 (32#32 - x_1)) &&& x <<< (x_1 + -1#32) != 0#32) =
        ofBool (x <<< (x_1 + -1#32) &&& truncate 32 (x_2 >>> zeroExtend 64 (32#32 - x_1)) != 0#32) :=
sorry