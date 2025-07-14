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

theorem or_and_xor_not_constant_commute1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 9),
  (x_1 ^^^ x) &&& 42#9 ||| x_1 &&& BitVec.ofInt 9 (-43) = x &&& 42#9 ^^^ x_1 :=
sorry