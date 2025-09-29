
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

theorem c_0_1_0_thm.extracted_1._2 : ∀ (x x_1 : BitVec 4),
  ¬(True ∧ (x &&& BitVec.ofInt 4 (-2) &&& (x_1 &&& 1#4) != 0) = true) →
    (x_1 ^^^ x) &&& BitVec.ofInt 4 (-2) ^^^ x_1 = x &&& BitVec.ofInt 4 (-2) ||| x_1 &&& 1#4 :=
sorry