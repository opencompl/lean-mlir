
/-
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
-/

theorem is_rem4_neg_i16_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(4#16 == 0 || 16 != 1 && x == intMin 16 && 4#16 == -1) = true →
    ofBool (x.srem 4#16 <ₛ 0#16) = ofBool (BitVec.ofInt 16 (-32768) <ᵤ x &&& BitVec.ofInt 16 (-32765)) :=
sorry