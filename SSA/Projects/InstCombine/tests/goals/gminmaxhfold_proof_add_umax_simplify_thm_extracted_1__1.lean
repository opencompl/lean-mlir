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

theorem add_umax_simplify_thm.extracted_1._1 : ∀ (x : BitVec 37),
  ¬(True ∧ x.uaddOverflow 42#37 = true) → ¬ofBool (42#37 <ᵤ x + 42#37) = 1#1 → 42#37 = x + 42#37 :=
sorry