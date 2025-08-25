
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

theorem uge_to_sgt_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (15#8 ≤ᵤ x ^^^ BitVec.ofInt 8 (-128)) = ofBool (BitVec.ofInt 8 (-114) <ₛ x) :=
sorry