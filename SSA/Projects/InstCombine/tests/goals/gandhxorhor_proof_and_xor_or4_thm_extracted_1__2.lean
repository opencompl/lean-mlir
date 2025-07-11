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

theorem and_xor_or4_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 64),
  ¬(x_2 = 0 ∨ x_1 = 0 ∨ x = 0 ∨ x_1 = 0) →
    ¬(x_2 = 0 ∨ x_1 = 0) → 42#64 / x_2 ^^^ 42#64 / x_1 &&& 42#64 / x ||| 42#64 / x_1 = 42#64 / x_2 ||| 42#64 / x_1 :=
sorry