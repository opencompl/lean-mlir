
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

theorem icmp_equality_test_constant_samesign_thm.extracted_1._2 : ∀ (x x_1 : BitVec 42),
  ¬ofBool (x_1 == BitVec.ofInt 42 (-42)) = 1#1 →
    ¬ofBool (x == BitVec.ofInt 42 (-42)) ^^^ 1#1 = 1#1 → 0#1 = ofBool (x_1 == x) :=
sorry