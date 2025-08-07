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

theorem shl_trunc_smaller_ashr_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(10#32 ≥ ↑32 ∨ 13#24 ≥ ↑24) →
    ¬3#24 ≥ ↑24 → truncate 24 (x.sshiftRight' 10#32) <<< 13#24 = truncate 24 x <<< 3#24 &&& BitVec.ofInt 24 (-8192) :=
sorry