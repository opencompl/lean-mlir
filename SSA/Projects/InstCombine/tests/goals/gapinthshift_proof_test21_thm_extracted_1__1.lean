
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

theorem test21_thm.extracted_1._1 : ∀ (x : BitVec 12),
  ¬6#12 ≥ ↑12 → ofBool (x <<< 6#12 == BitVec.ofInt 12 (-128)) = ofBool (x &&& 63#12 == 62#12) :=
sorry