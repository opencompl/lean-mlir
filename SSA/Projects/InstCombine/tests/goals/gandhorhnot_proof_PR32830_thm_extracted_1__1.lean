
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

theorem PR32830_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 64),
  (x_2 ^^^ -1#64 ||| x_1) &&& (x_1 ^^^ -1#64 ||| x) = (x_1 ||| x_2 ^^^ -1#64) &&& (x ||| x_1 ^^^ -1#64) :=
sorry