
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

theorem test18_thm.extracted_1._4 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  ¬ofBool (x &&& 4#16 != 0#16) = 1#1 → ¬ofBool (x &&& 4#16 == 0#16) = 1#1 → ¬64#32 = 0 → x_1 % 64#32 = x_1 &&& 31#32 :=
sorry