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

theorem same_signbit_wrong_type_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 8),
  ¬7#8 ≥ ↑8 →
    ofBool (x_1 >>> 7#8 != zeroExtend 8 (ofBool (-1#32 <ₛ x))) = ofBool (x_1 <ₛ 0#8) ^^^ ofBool (-1#32 <ₛ x) :=
sorry