
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false
-/

theorem test11_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(True ∧ (x &&& BitVec.ofInt 8 (-13) &&& 8#8 != 0) = true) →
    (x ||| 12#8) ^^^ 4#8 = x &&& BitVec.ofInt 8 (-13) ||| 8#8 :=
sorry