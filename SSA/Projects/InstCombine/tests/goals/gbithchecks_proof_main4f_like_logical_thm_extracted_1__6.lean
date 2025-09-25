
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

theorem main4f_like_logical_thm.extracted_1._6 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 != x_1) = 1#1 →
    ofBool (x_2 &&& x_1 == x_1) = 1#1 → ¬True → 0#32 = zeroExtend 32 (ofBool (x_2 &&& x == x)) :=
sorry