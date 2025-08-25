
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

theorem udiv_exact_eq_1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ x_1.umod x ≠ 0 ∨ x = 0) → ofBool (x_1 / x != 1#8) = ofBool (x_1 != x) :=
sorry