
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

theorem neg_slt_n1_thm.extracted_1._1 : ∀ (x : BitVec 8), ofBool (0#8 - x <ₛ -1#8) = ofBool (0#8 <ₛ x + -1#8) :=
sorry