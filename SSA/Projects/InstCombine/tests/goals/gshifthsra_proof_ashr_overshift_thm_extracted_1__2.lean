
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

theorem ashr_overshift_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(15#32 ≥ ↑32 ∨ 17#32 ≥ ↑32) → ¬31#32 ≥ ↑32 → (x.sshiftRight' 15#32).sshiftRight' 17#32 = x.sshiftRight' 31#32 :=
sorry