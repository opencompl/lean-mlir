
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

theorem positive_with_mask_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 1107296256#32 == 0#32) = 1#1 → ofBool (x + 128#32 <ᵤ 256#32) = ofBool (x <ᵤ 128#32) :=
sorry