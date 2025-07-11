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

theorem is_rem2_neg_i8_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(2#8 == 0 || 8 != 1 && x == intMin 8 && 2#8 == -1) = true →
    ofBool (x.srem 2#8 <ₛ 0#8) = ofBool (x &&& BitVec.ofInt 8 (-127) == BitVec.ofInt 8 (-127)) :=
sorry