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

theorem test_add_nuw_nsw__nsw_is_safe_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ofBool (x ||| BitVec.ofInt 32 (-2147483648) == -1#32) = 1#1 →
    ¬(True ∧ (x ||| BitVec.ofInt 32 (-2147483648)).saddOverflow 1#32 = true) →
      0#32 = (x ||| BitVec.ofInt 32 (-2147483648)) + 1#32 :=
sorry