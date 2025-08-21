
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

theorem sdiv_eq_smin_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(x == 0 || 8 != 1 && x_1 == intMin 8 && x == -1) = true →
    ofBool (x_1.sdiv x == BitVec.ofInt 8 (-128)) = ofBool (x_1 == BitVec.ofInt 8 (-128)) &&& ofBool (x == 1#8) :=
sorry