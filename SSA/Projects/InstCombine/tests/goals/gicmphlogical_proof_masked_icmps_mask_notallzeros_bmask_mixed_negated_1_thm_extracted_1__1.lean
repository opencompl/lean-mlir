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

theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_1_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 12#32 == 0#32) ||| ofBool (x &&& 7#32 != 1#32) = ofBool (x &&& 15#32 != 9#32) :=
sorry