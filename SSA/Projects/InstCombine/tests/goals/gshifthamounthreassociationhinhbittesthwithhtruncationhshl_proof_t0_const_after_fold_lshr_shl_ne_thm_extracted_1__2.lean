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

theorem t0_const_after_fold_lshr_shl_ne_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 x_2 : BitVec 32),
  ¬(32#32 - x_1 ≥ ↑32 ∨ zeroExtend 64 (x_1 + -1#32) ≥ ↑64) →
    ¬(31#32 ≥ ↑32 ∨ True ∧ (x_2 >>> 31#32).msb = true) →
      ofBool (x_2 >>> (32#32 - x_1) &&& truncate 32 (x <<< zeroExtend 64 (x_1 + -1#32)) != 0#32) =
        ofBool (x &&& zeroExtend 64 (x_2 >>> 31#32) != 0#64) :=
sorry