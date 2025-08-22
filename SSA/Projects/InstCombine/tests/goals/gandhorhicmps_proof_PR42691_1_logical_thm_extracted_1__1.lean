
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

theorem PR42691_1_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x <ₛ 0#32) = 1#1 → 1#1 = ofBool (2147483646#32 <ᵤ x) :=
sorry