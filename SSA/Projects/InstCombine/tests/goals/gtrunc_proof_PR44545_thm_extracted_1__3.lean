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

theorem PR44545_thm.extracted_1._3 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 == 0#32) = 1#1 →
    ¬(True ∧ x.saddOverflow 1#32 = true ∨ True ∧ x.uaddOverflow 1#32 = true) →
      ¬(True ∧ (truncate 16 (x + 1#32)).saddOverflow (-1#16) = true) → truncate 16 (x + 1#32) + -1#16 = truncate 16 x :=
sorry