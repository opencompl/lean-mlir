
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

theorem low_bitmask_ult_thm.extracted_1._1 : ∀ (x : BitVec 8), ofBool (x + 31#8 &&& 31#8 <ᵤ x) = ofBool (x != 0#8) :=
sorry