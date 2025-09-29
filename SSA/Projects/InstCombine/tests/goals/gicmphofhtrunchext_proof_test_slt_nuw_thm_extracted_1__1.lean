
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

theorem test_slt_nuw_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  ¬(True ∧ signExtend 32 (truncate 8 x_1) ≠ x_1 ∨
        True ∧ zeroExtend 32 (truncate 8 x_1) ≠ x_1 ∨
          True ∧ signExtend 16 (truncate 8 x) ≠ x ∨ True ∧ zeroExtend 16 (truncate 8 x) ≠ x) →
    ofBool (truncate 8 x_1 <ₛ truncate 8 x) = ofBool (x_1 <ₛ zeroExtend 32 x) :=
sorry