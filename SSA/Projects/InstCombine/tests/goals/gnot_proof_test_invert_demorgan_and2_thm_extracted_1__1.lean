
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

theorem test_invert_demorgan_and2_thm.extracted_1._1 : ∀ (x : BitVec 64),
  x + 9223372036854775807#64 &&& 9223372036854775807#64 ^^^ -1#64 =
    0#64 - x ||| BitVec.ofInt 64 (-9223372036854775808) :=
sorry