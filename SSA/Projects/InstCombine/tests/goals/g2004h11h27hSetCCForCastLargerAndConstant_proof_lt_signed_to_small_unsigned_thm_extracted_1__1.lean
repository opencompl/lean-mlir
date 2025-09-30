
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

theorem lt_signed_to_small_unsigned_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (signExtend 32 x <ᵤ 17#32) = ofBool (x <ᵤ 17#8) :=
sorry