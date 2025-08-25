
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

theorem positive_trunc_base_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (-1#16 <ₛ truncate 16 x) = 1#1 → ofBool (truncate 16 x + 128#16 <ᵤ 256#16) = ofBool (x &&& 65408#32 == 0#32) :=
sorry