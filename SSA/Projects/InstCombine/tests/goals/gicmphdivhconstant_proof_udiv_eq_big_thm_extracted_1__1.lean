
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

theorem udiv_eq_big_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬x = 0 → ofBool (x_1 / x == BitVec.ofInt 8 (-128)) = ofBool (x_1 == BitVec.ofInt 8 (-128)) &&& ofBool (x == 1#8) :=
sorry