
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

theorem ult_192_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (truncate 8 x <ᵤ BitVec.ofInt 8 (-64)) = ofBool (x &&& 192#32 != 192#32) :=
sorry