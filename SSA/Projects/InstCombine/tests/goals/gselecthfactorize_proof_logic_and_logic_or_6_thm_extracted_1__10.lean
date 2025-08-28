
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

theorem logic_and_logic_or_6_thm.extracted_1._10 : ∀ (x x_1 x_2 : BitVec 1),
  ¬x_2 = 1#1 → ¬x = 1#1 → 0#1 = 1#1 → 1#1 = 0#1 :=
sorry