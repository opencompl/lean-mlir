
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

theorem rem_euclid_wrong_sign_test_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(8#32 == 0 || 32 != 1 && x == intMin 32 && 8#32 == -1) = true →
    ofBool (0#32 <ₛ x.srem 8#32) = 1#1 →
      (8#32 == 0 || 32 != 1 && x == intMin 32 && 8#32 == -1) = true ∨ True ∧ (x.srem 8#32).saddOverflow 8#32 = true →
        False :=
sorry