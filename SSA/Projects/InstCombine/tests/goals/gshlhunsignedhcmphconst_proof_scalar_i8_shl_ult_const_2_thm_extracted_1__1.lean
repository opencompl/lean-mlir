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

theorem scalar_i8_shl_ult_const_2_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬6#8 ≥ ↑8 → ofBool (x <<< 6#8 <ᵤ 64#8) = ofBool (x &&& 3#8 == 0#8) :=
sorry