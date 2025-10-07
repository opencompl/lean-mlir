
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

theorem test73_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (-1#8 <ₛ truncate 8 x) = 1#1 → ofBool (x &&& 128#32 == 0#32) = 1#1 → 42#32 = 40#32 :=
sorry