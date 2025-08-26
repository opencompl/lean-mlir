
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

theorem sext_shl_trunc_smaller_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 16),
  ¬x ≥ ↑32 → truncate 5 (signExtend 32 x_1 <<< x) = truncate 5 (zeroExtend 32 x_1 <<< x) :=
sorry