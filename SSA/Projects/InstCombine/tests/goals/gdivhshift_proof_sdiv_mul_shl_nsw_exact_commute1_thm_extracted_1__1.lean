
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

theorem sdiv_mul_shl_nsw_exact_commute1_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 5),
  ¬(True ∧ x_2.smulOverflow x_1 = true ∨
        True ∧ (x_1 <<< x).sshiftRight' x ≠ x_1 ∨
          x ≥ ↑5 ∨
            True ∧ (x_2 * x_1).smod (x_1 <<< x) ≠ 0 ∨
              (x_1 <<< x == 0 || 5 != 1 && x_2 * x_1 == intMin 5 && x_1 <<< x == -1) = true) →
    True ∧ 1#5 <<< x >>> x ≠ 1#5 ∨
        x ≥ ↑5 ∨
          True ∧ x_2.smod (1#5 <<< x) ≠ 0 ∨ (1#5 <<< x == 0 || 5 != 1 && x_2 == intMin 5 && 1#5 <<< x == -1) = true →
      False :=
sorry