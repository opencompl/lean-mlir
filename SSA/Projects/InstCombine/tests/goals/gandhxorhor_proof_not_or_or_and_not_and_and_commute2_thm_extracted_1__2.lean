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

theorem not_or_or_and_not_and_and_commute2_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ¬((x == 0 || 32 != 1 && 42#32 == intMin 32 && x == -1) = true ∨
        (x == 0 || 32 != 1 && 42#32 == intMin 32 && x == -1) = true) →
    ¬(x == 0 || 32 != 1 && 42#32 == intMin 32 && x == -1) = true →
      (x_2 ^^^ -1#32 ||| x_1 ||| (42#32).sdiv x) &&& ((42#32).sdiv x &&& (x_1 &&& x_2) ^^^ -1#32) =
        (42#32).sdiv x ^^^ x_1 ||| x_2 ^^^ -1#32 :=
sorry