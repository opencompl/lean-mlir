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

theorem slt_zero_eq_i1_signed_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  ¬31#32 ≥ ↑32 → ofBool (signExtend 32 x_1 == x.sshiftRight' 31#32) = ofBool (-1#32 <ₛ x) ^^^ x_1 :=
sorry