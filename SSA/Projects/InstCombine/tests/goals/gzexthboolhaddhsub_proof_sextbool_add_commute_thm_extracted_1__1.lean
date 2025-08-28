
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

theorem sextbool_add_commute_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 : BitVec 32),
  ¬42#32 = 0 → 42#32 = 0 ∨ True ∧ (x_1 % 42#32).saddOverflow (signExtend 32 x) = true → False :=
sorry