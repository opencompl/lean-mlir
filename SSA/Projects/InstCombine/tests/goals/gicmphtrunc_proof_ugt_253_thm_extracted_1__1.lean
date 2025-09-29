
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

theorem ugt_253_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (BitVec.ofInt 8 (-3) <ᵤ truncate 8 x) = ofBool (x &&& 254#32 == 254#32) :=
sorry