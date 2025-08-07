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

theorem test_shift_negative_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧
          ((x_1 ||| BitVec.ofInt 32 (-2147483648)) <<< (x &&& 7#32)).sshiftRight' (x &&& 7#32) ≠
            x_1 ||| BitVec.ofInt 32 (-2147483648) ∨
        x &&& 7#32 ≥ ↑32) →
    ofBool ((x_1 ||| BitVec.ofInt 32 (-2147483648)) <<< (x &&& 7#32) <ₛ 0#32) = 1#1 :=
sorry