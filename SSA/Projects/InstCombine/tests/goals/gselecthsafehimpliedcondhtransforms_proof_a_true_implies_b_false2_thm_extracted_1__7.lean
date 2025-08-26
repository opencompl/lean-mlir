
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

theorem a_true_implies_b_false2_thm.extracted_1._7 : ∀ (x x_1 : BitVec 1) (x_2 : BitVec 8),
  ¬ofBool (x_2 == 10#8) = 1#1 → ofBool (20#8 <ᵤ x_2) = 1#1 → ofBool (20#8 <ᵤ x_2) &&& x = x :=
sorry