
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

theorem sub_from_constant_of_add_with_constant_thm.extracted_1._1 : ∀ (x : BitVec 8),
  11#8 - (x + 42#8) = BitVec.ofInt 8 (-31) - x :=
sorry