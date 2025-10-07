
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

theorem PR42691_6_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x <ᵤ BitVec.ofInt 32 (-2147483647)) = 1#1 →
    ofBool (x == -1#32) = ofBool (x + 1#32 <ᵤ BitVec.ofInt 32 (-2147483646)) :=
sorry