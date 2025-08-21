
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

theorem masked_or_allzeroes_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 == 0#32) = 1#1 → ofBool (x &&& 39#32 == 0#32) = ofBool (x &&& 7#32 == 0#32) :=
sorry