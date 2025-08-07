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

theorem different_size_zext_zext_eq_thm.extracted_1._1 : ∀ (x : BitVec 7) (x_1 : BitVec 4),
  ofBool (zeroExtend 25 x_1 == zeroExtend 25 x) = ofBool (x == zeroExtend 7 x_1) :=
sorry