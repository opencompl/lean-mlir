
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

theorem src_is_mask_select_thm.extracted_1._3 : ∀ (x x_1 : BitVec 8) (x_2 : BitVec 1),
  ¬x_2 = 1#1 → ofBool (15#8 &&& (x ^^^ 123#8) != x ^^^ 123#8) = ofBool (15#8 <ᵤ x ^^^ 123#8) :=
sorry