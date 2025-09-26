
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

theorem test7_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(4#32 == 0 || 32 != 1 && x * 8#32 == intMin 32 && 4#32 == -1) = true → (x * 8#32).srem 4#32 = 0#32 :=
sorry