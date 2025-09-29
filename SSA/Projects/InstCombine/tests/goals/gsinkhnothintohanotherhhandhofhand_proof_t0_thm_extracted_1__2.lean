
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

theorem t0_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 8) (x_3 : BitVec 1),
  ¬(x_3 ^^^ 1#1) &&& ofBool (x_2 == x_1) = 1#1 → ¬ofBool (x_2 != x_1) ||| x_3 = 1#1 → False :=
sorry