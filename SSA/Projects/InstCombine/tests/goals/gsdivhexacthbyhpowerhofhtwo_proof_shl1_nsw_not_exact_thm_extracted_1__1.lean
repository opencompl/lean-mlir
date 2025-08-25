
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

theorem shl1_nsw_not_exact_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ (1#8 <<< x).sshiftRight' x ≠ 1#8 ∨
        x ≥ ↑8 ∨ (1#8 <<< x == 0 || 8 != 1 && x_1 == intMin 8 && 1#8 <<< x == -1) = true) →
    True ∧ (1#8 <<< x).sshiftRight' x ≠ 1#8 ∨
        True ∧ 1#8 <<< x >>> x ≠ 1#8 ∨
          x ≥ ↑8 ∨ (1#8 <<< x == 0 || 8 != 1 && x_1 == intMin 8 && 1#8 <<< x == -1) = true →
      False :=
sorry