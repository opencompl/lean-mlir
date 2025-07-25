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

theorem t0_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬16#32 ≥ ↑32 →
    zeroExtend 32 x <<< 16#32 &&& BitVec.ofInt 32 (-2147483648) = signExtend 32 x &&& BitVec.ofInt 32 (-2147483648) :=
sorry