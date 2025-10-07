
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

theorem lshrugt_03_00_exact_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬(True ∧ x >>> 3#4 <<< 3#4 ≠ x ∨ 3#4 ≥ ↑4) → ofBool (0#4 <ᵤ x >>> 3#4) = ofBool (x != 0#4) :=
sorry