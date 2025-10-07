
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

theorem test9_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 1073741824#32 != 0#32) &&& ofBool (-1#32 <ₛ x) =
    ofBool (x &&& BitVec.ofInt 32 (-1073741824) == 1073741824#32) :=
sorry