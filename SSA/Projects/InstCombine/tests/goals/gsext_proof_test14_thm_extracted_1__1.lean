
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

theorem test14_thm.extracted_1._1 : ∀ (x : BitVec 16),
  4#16 ≥ ↑16 ∨ True ∧ (x >>> 4#16 &&& 1#16).saddOverflow (-1#16) = true → False :=
sorry