
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

theorem shl1_trunc_eq0_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → ofBool (truncate 16 (1#32 <<< x) == 0#16) = ofBool (15#32 <ᵤ x) :=
sorry