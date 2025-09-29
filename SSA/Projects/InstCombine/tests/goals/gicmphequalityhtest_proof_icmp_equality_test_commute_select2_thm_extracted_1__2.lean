
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

theorem icmp_equality_test_commute_select2_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 64),
  ¬ofBool (x_2 == x_1) ^^^ 1#1 = 1#1 → ofBool (x == x_1) = ofBool (x_2 == x) :=
sorry