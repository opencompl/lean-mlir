
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

theorem t1_ult_slt_0_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x + 16#32 <ᵤ 144#32) = 1#1 → ofBool (127#32 <ₛ x) = 1#1 ∨ ofBool (x <ₛ BitVec.ofInt 32 (-16)) = 1#1 → False :=
sorry