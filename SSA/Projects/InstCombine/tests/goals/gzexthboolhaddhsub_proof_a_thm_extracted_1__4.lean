
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

theorem a_thm.extracted_1._4 : ∀ (x x_1 : BitVec 1),
  ¬x_1 = 1#1 →
    ¬(True ∧ (1#32).saddOverflow (signExtend 32 x) = true) →
      zeroExtend 32 x_1 + 1#32 + (0#32 - zeroExtend 32 x) = 1#32 + signExtend 32 x :=
sorry