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

theorem ugt_swap_or_not_min_commute_logical_thm.extracted_1._3 : ∀ (x x_1 : BitVec 823),
  ¬ofBool (x_1 != 0#823) = 1#1 → ofBool (x <ᵤ x_1) = ofBool (x_1 != 0#823) :=
sorry