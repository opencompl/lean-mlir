
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

theorem mul_splat_fold_too_narrow_thm.extracted_1._1 : ∀ (x : BitVec 2),
  ¬(True ∧ x.umulOverflow (BitVec.ofInt 2 (-2)) = true ∨ 1#2 ≥ ↑2) → (x * BitVec.ofInt 2 (-2)) >>> 1#2 = x :=
sorry