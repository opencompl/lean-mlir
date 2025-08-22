
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

theorem mul_add_to_mul_3_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(True ∧ (x * 2#16).saddOverflow (x * 3#16) = true) → x * 2#16 + x * 3#16 = x * 5#16 :=
sorry