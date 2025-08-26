
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

theorem test_const_shr_exact_and_1_ne_0_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ 42#32 >>> x <<< x ≠ 42#32 ∨ x ≥ ↑32) →
    ¬(True ∧ 1#32 <<< x >>> x ≠ 1#32 ∨ x ≥ ↑32) →
      ofBool (42#32 >>> x &&& 1#32 != 0#32) = ofBool (1#32 <<< x &&& 42#32 != 0#32) :=
sorry