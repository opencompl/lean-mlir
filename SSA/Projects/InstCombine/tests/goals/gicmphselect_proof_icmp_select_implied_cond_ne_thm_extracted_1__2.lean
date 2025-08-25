
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

theorem icmp_select_implied_cond_ne_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ofBool (x == 0#8) = 1#1 → ¬ofBool (x != 0#8) = 1#1 → ofBool (0#8 != x) = 0#1 :=
sorry