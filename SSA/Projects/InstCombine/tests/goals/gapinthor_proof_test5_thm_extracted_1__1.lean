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

theorem test5_thm.extracted_1._1 : ∀ (x x_1 : BitVec 399),
  x_1 + (x &&& 18446742974197923840#399) &&& (274877906943#399 ^^^ -1#399) ||| x_1 &&& 274877906943#399 =
    x_1 + (x &&& 18446742974197923840#399) :=
sorry