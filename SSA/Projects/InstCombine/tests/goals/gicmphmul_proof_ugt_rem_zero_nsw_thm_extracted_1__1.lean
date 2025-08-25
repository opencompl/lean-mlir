
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

theorem ugt_rem_zero_nsw_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x.smulOverflow 7#8 = true ∨ True ∧ x.umulOverflow 7#8 = true) →
    ofBool (21#8 <ᵤ x * 7#8) = ofBool (3#8 <ᵤ x) :=
sorry