
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

theorem test_sub_nsw__nuw_is_safe_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 2147483647#32 == 1073741824#32) = 1#1 →
    ¬(True ∧ (BitVec.ofInt 32 (-2147483648)).ssubOverflow (x &&& 2147483647#32) = true) →
      True ∧ (BitVec.ofInt 32 (-2147483648)).usubOverflow (x &&& 2147483647#32) = true → False :=
sorry