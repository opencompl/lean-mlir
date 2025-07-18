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

theorem shl_add_lshr_flag_preservation_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ¬(True ∧ x_2 <<< x_1 >>> x_1 ≠ x_2 ∨
        x_1 ≥ ↑32 ∨
          True ∧ (x_2 <<< x_1).saddOverflow x = true ∨
            True ∧ (x_2 <<< x_1).uaddOverflow x = true ∨
              True ∧ (x_2 <<< x_1 + x) >>> x_1 <<< x_1 ≠ x_2 <<< x_1 + x ∨ x_1 ≥ ↑32) →
    ¬(True ∧ x >>> x_1 <<< x_1 ≠ x ∨
          x_1 ≥ ↑32 ∨ True ∧ (x >>> x_1).saddOverflow x_2 = true ∨ True ∧ (x >>> x_1).uaddOverflow x_2 = true) →
      (x_2 <<< x_1 + x) >>> x_1 = x >>> x_1 + x_2 :=
sorry