
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

theorem canonicalize_logic_first_or0_thm.extracted_1._1 : ∀ (x : BitVec 32),
  x + 112#32 ||| 15#32 = (x ||| 15#32) + 112#32 :=
sorry