
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

theorem masked_and_notA_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 14#32 != x) = 1#1 → 0#1 = ofBool (x &&& BitVec.ofInt 32 (-79) != 0#32) :=
sorry