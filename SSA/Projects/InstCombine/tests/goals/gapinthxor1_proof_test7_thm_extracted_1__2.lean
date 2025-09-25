
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

theorem test7_thm.extracted_1._2 : ∀ (x : BitVec 47),
  ¬(True ∧ (x &&& BitVec.ofInt 47 (-70368744177664) &&& 70368040490200#47 != 0) = true) →
    (x ||| 70368744177663#47) ^^^ 703687463#47 = x &&& BitVec.ofInt 47 (-70368744177664) ||| 70368040490200#47 :=
sorry