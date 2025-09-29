
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

theorem positive_with_aggressive_icmp_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x <ᵤ 128#32) = 1#1 → ofBool (x + 256#32 <ᵤ 512#32) = ofBool (x <ᵤ 128#32) :=
sorry