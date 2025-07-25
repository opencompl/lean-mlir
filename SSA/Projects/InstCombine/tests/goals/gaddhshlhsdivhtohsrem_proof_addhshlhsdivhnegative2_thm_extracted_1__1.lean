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

theorem addhshlhsdivhnegative2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬((BitVec.ofInt 32 (-2147483648) == 0 || 32 != 1 && x == intMin 32 && BitVec.ofInt 32 (-2147483648) == -1) = true ∨
        31#32 ≥ ↑32) →
    ofBool (x == BitVec.ofInt 32 (-2147483648)) = 1#1 →
      x.sdiv (BitVec.ofInt 32 (-2147483648)) <<< 31#32 + x = BitVec.ofInt 32 (-2147483648) + x :=
sorry