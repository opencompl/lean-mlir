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

theorem pr51551_neg1_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ (x_1 &&& BitVec.ofInt 32 (-3) ||| 1#32).smulOverflow x = true) →
    ¬(True ∧ (x_1 &&& 4#32 &&& 1#32 != 0) = true) →
      ofBool ((x_1 &&& BitVec.ofInt 32 (-3) ||| 1#32) * x &&& 7#32 == 0#32) =
        ofBool ((x_1 &&& 4#32 ||| 1#32) * x &&& 7#32 == 0#32) :=
sorry