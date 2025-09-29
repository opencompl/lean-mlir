
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

theorem or_ne_notY_eq_1s_fail_bad_not_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 ||| x ^^^ BitVec.ofInt 8 (-2) != x_1) = ofBool (x_1 ||| x ^^^ 1#8 != -1#8) :=
sorry