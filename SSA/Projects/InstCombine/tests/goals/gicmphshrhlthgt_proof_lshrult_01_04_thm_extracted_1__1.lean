
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

theorem lshrult_01_04_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬1#4 ≥ ↑4 → ofBool (x >>> 1#4 <ᵤ 4#4) = ofBool (-1#4 <ₛ x) :=
sorry