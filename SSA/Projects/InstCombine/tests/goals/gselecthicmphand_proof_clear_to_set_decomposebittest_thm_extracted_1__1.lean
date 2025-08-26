
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

theorem clear_to_set_decomposebittest_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (-1#8 <ₛ x) = 1#1 → BitVec.ofInt 8 (-125) = x &&& BitVec.ofInt 8 (-128) ^^^ BitVec.ofInt 8 (-125) :=
sorry