
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

theorem exact_lshr_ne_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ 4#8 >>> x <<< x ≠ 4#8 ∨ x ≥ ↑8) → ofBool (4#8 >>> x != 1#8) = ofBool (x != 2#8) :=
sorry