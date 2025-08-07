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

theorem shift_trunc_wrong_shift_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬23#32 ≥ ↑32 → ofBool (truncate 8 (x >>> 23#32) <ₛ 0#8) = ofBool (x &&& 1073741824#32 != 0#32) :=
sorry