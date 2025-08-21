
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

theorem not_and_and_or_not_or_or_commute1_and_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  (x_2 ^^^ -1#32) &&& x_1 &&& x ||| (x ||| x_2 ||| x_1) ^^^ -1#32 = (x ^^^ x_1 ||| x_2) ^^^ -1#32 :=
sorry