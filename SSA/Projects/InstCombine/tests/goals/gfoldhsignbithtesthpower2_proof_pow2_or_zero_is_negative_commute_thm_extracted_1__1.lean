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

theorem pow2_or_zero_is_negative_commute_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (0#8 - 42#8 * x &&& 42#8 * x <ₛ 0#8) = ofBool (x * 42#8 == BitVec.ofInt 8 (-128)) :=
sorry