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

theorem icmp_mul_nsw_slt_neg_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ x_1.smulOverflow (BitVec.ofInt 8 (-7)) = true ∨ True ∧ x.smulOverflow (BitVec.ofInt 8 (-7)) = true) →
    ofBool (x_1 * BitVec.ofInt 8 (-7) <ₛ x * BitVec.ofInt 8 (-7)) = ofBool (x <ₛ x_1) :=
sorry