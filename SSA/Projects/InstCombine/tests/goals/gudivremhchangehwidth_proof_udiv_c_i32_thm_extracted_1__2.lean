
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

theorem udiv_c_i32_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬zeroExtend 32 x = 0 → ¬(x = 0 ∨ True ∧ (10#8 / x).msb = true) → 10#32 / zeroExtend 32 x = zeroExtend 32 (10#8 / x) :=
sorry