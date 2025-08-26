
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

theorem select_bittest_to_shl_negative_test_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 1#32 == 0#32) = 1#1 →
    ¬(True ∧ (4#32).saddOverflow 2#32 = true ∨ True ∧ (4#32).uaddOverflow 2#32 = true) → 4#32 + 2#32 = 6#32 :=
sorry