
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

theorem t0_thm.extracted_1._4 : ∀ (x x_1 x_2 x_3 : BitVec 8) (x_4 : BitVec 1),
  ¬x_4 ^^^ 1#1 ||| ofBool (x_3 == x_2) = 1#1 → ¬ofBool (x_3 != x_2) &&& x_4 = 1#1 → x = x_1 :=
sorry