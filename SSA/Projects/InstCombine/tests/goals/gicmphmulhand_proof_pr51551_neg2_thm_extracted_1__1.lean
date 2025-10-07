
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

theorem pr51551_neg2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ (x_1 &&& BitVec.ofInt 32 (-7)).smulOverflow x = true) →
    truncate 1 x_1 ^^^ 1#1 = 1#1 → ofBool ((x_1 &&& BitVec.ofInt 32 (-7)) * x &&& 7#32 == 0#32) = 1#1 :=
sorry