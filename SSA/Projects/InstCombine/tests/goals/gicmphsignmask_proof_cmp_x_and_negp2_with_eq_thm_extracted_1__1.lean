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

theorem cmp_x_and_negp2_with_eq_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (x &&& BitVec.ofInt 8 (-2) == BitVec.ofInt 8 (-128)) = ofBool (x <ₛ BitVec.ofInt 8 (-126)) :=
sorry