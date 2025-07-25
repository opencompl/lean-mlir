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

theorem exact_lshr_eq_exactdiv_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ 80#8 >>> x <<< x ≠ 80#8 ∨ x ≥ ↑8) → ofBool (80#8 >>> x == 5#8) = ofBool (x == 4#8) :=
sorry