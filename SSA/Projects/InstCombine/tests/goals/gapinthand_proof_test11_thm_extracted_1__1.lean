
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

theorem test11_thm.extracted_1._1 : ∀ (x : BitVec 737),
  ofBool (x &&& BitVec.ofInt 737 (-2147483648) != 0#737) = ofBool (2147483647#737 <ᵤ x) :=
sorry