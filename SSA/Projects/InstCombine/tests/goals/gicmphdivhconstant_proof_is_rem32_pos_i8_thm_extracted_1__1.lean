
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
import SSA.Projects.InstCombine.TacticAuto
import LeanMLIR.Dialects.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false
-/

theorem is_rem32_pos_i8_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(32#8 == 0 || 8 != 1 && x == intMin 8 && 32#8 == -1) = true →
    ofBool (0#8 <ₛ x.srem 32#8) = ofBool (0#8 <ₛ x &&& BitVec.ofInt 8 (-97)) :=
sorry