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

theorem exact_lshr_eq_both_equal_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ 126#8 >>> x <<< x ≠ 126#8 ∨ x ≥ ↑8) → ofBool (126#8 >>> x == 126#8) = ofBool (x == 0#8) :=
sorry