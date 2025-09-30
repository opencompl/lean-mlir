
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

theorem lt_unsigned_to_small_negative_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (zeroExtend 32 x <ₛ BitVec.ofInt 32 (-17)) = 0#1 :=
sorry