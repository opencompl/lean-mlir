
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

theorem test5_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬16#128 ≥ ↑128 → ¬16#32 ≥ ↑32 → truncate 32 (zeroExtend 128 x >>> 16#128) = x >>> 16#32 :=
sorry