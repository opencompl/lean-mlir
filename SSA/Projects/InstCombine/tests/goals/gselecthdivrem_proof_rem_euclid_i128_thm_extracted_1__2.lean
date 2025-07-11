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

theorem rem_euclid_i128_thm.extracted_1._2 : ∀ (x : BitVec 128),
  ¬(8#128 == 0 || 128 != 1 && x == intMin 128 && 8#128 == -1) = true →
    ¬ofBool (x.srem 8#128 <ₛ 0#128) = 1#1 → x.srem 8#128 = x &&& 7#128 :=
sorry