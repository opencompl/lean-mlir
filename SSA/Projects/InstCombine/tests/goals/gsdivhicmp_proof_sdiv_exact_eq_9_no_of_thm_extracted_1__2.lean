
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

theorem sdiv_exact_eq_9_no_of_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ x_1.smod (x &&& 7#8) ≠ 0 ∨ (x &&& 7#8 == 0 || 8 != 1 && x_1 == intMin 8 && x &&& 7#8 == -1) = true) →
    ¬(True ∧ (x &&& 7#8).smulOverflow 9#8 = true ∨ True ∧ (x &&& 7#8).umulOverflow 9#8 = true) →
      ofBool (x_1.sdiv (x &&& 7#8) == 9#8) = ofBool ((x &&& 7#8) * 9#8 == x_1) :=
sorry