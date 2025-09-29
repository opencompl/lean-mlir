
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

theorem select_or_disjoint_or_thm.extracted_1._2 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  ¬x_1 = 1#1 →
    ¬(4#32 ≥ ↑32 ∨ True ∧ (4#32 &&& x <<< 4#32 != 0) = true) →
      4#32 ≥ ↑32 ∨
          True ∧ (4#32 &&& x <<< 4#32 != 0) = true ∨
            True ∧ (4#32 ||| x <<< 4#32).saddOverflow 4#32 = true ∨
              True ∧ (4#32 ||| x <<< 4#32).uaddOverflow 4#32 = true →
        False :=
sorry