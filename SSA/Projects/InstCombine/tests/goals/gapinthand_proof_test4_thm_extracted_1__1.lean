
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

theorem test4_thm.extracted_1._1 : ∀ (x : BitVec 37),
  ofBool (x &&& BitVec.ofInt 37 (-2147483648) != 0#37) = ofBool (2147483647#37 <ᵤ x) :=
sorry