
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

theorem rawspeed_signbit_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬(True ∧ x_1.saddOverflow (-1#32) = true ∨
        x_1 + -1#32 ≥ ↑32 ∨ True ∧ (64#32).ssubOverflow x_1 = true ∨ zeroExtend 64 (64#32 - x_1) ≥ ↑64) →
    ofBool (1#32 <<< (x_1 + -1#32) &&& truncate 32 (x >>> zeroExtend 64 (64#32 - x_1)) == 0#32) = ofBool (-1#64 <ₛ x) :=
sorry