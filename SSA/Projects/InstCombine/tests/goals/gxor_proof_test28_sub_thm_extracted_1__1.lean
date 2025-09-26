
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

theorem test28_sub_thm.extracted_1._1 : ∀ (x : BitVec 32),
  BitVec.ofInt 32 (-2147483647) - x ^^^ BitVec.ofInt 32 (-2147483648) = 1#32 - x :=
sorry