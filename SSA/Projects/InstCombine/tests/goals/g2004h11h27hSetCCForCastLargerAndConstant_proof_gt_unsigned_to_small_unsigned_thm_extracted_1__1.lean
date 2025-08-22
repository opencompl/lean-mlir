
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

theorem gt_unsigned_to_small_unsigned_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (17#32 <ᵤ zeroExtend 32 x) = ofBool (17#8 <ᵤ x) :=
sorry