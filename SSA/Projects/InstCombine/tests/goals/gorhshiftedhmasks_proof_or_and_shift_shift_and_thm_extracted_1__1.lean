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

theorem or_and_shift_shift_and_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(3#32 ≥ ↑32 ∨ 2#32 ≥ ↑32) →
    (x &&& 7#32) <<< 3#32 ||| x <<< 2#32 &&& 28#32 = x <<< 3#32 &&& 56#32 ||| x <<< 2#32 &&& 28#32 :=
sorry