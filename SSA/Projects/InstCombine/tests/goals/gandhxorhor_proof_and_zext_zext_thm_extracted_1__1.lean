
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

theorem and_zext_zext_thm.extracted_1._1 : ∀ (x : BitVec 4) (x_1 : BitVec 8),
  True ∧ (x_1 &&& zeroExtend 8 x).msb = true → False :=
sorry