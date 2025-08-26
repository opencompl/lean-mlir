
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

theorem uadd_sat_flipped_wrong_bounds6_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x ≤ᵤ BitVec.ofInt 32 (-12)) = 1#1 → ofBool (x <ᵤ BitVec.ofInt 32 (-11)) = 1#1 → -1#32 = x + 9#32 :=
sorry