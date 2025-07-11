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

theorem foo1_or_signbit_lshr_without_shifting_signbit_both_sides_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ¬(x_1 ≥ ↑32 ∨ x ≥ ↑32) →
    ofBool (x_2 <<< x_1 <ₛ 0#32) &&& ofBool (x_2 <<< x <ₛ 0#32) = ofBool (x_2 <<< x_1 &&& x_2 <<< x <ₛ 0#32) :=
sorry