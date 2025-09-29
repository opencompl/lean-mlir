
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

theorem positive_biggerLshr_lshrexact_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(5#32 ≥ ↑32 ∨ True ∧ x <<< 5#32 >>> 10#32 <<< 10#32 ≠ x <<< 5#32 ∨ 10#32 ≥ ↑32) →
    True ∧ x >>> 5#32 <<< 5#32 ≠ x ∨ 5#32 ≥ ↑32 → False :=
sorry