
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

theorem trunc_lshr_trunc_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬8#32 ≥ ↑32 → ¬8#64 ≥ ↑64 → truncate 8 (truncate 32 x >>> 8#32) = truncate 8 (x >>> 8#64) :=
sorry