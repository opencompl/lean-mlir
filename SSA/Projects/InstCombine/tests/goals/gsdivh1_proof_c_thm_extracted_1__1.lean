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

theorem c_thm.extracted_1._1 : ¬(BitVec.ofInt 32 (-3) == 0 ||
        32 != 1 && 0#32 - BitVec.ofInt 32 (-2147483648) == intMin 32 && BitVec.ofInt 32 (-3) == -1) =
      true →
  (0#32 - BitVec.ofInt 32 (-2147483648)).sdiv (BitVec.ofInt 32 (-3)) = 715827882#32 :=
sorry