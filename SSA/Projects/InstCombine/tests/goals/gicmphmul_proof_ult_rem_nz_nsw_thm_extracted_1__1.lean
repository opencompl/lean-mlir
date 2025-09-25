
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

theorem ult_rem_nz_nsw_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x.smulOverflow 5#8 = true ∨ True ∧ x.umulOverflow 5#8 = true) →
    ofBool (x * 5#8 <ᵤ 21#8) = ofBool (x <ᵤ 5#8) :=
sorry