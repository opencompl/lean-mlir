
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

theorem trunc_unsigned_both_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬(True ∧ signExtend 16 (truncate 8 x_1) ≠ x_1 ∨
        True ∧ zeroExtend 16 (truncate 8 x_1) ≠ x_1 ∨
          True ∧ signExtend 16 (truncate 8 x) ≠ x ∨ True ∧ zeroExtend 16 (truncate 8 x) ≠ x) →
    ofBool (truncate 8 x_1 <ᵤ truncate 8 x) = ofBool (x_1 <ᵤ x) :=
sorry