
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

theorem test7_thm.extracted_1._1 : ∀ (x : BitVec 1023),
  True ∧ (x &&& BitVec.ofInt 1023 (-70368744177664) &&& 70368040490200#1023 != 0) = true → False :=
sorry