
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

theorem test15a_thm.extracted_1._1 : ∀ (x : BitVec 1),
  x = 1#1 → ¬zeroExtend 53 3#8 ≥ ↑53 → 64#53 <<< zeroExtend 53 3#8 = 512#53 :=
sorry