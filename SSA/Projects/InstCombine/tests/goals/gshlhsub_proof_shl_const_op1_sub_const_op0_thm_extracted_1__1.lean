
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

theorem shl_const_op1_sub_const_op0_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬3#32 ≥ ↑32 → (42#32 - x) <<< 3#32 = 336#32 - x <<< 3#32 :=
sorry