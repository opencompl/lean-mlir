
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

theorem two_signed_truncation_checks_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬ofBool (x + 512#32 <ᵤ 1024#32) = 1#1 → 0#1 = ofBool (x + 128#32 <ᵤ 256#32) :=
sorry