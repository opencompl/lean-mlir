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

theorem test40_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(9#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
    ¬(9#16 ≥ ↑16 ∨ 8#16 ≥ ↑16 ∨ True ∧ (x >>> 9#16 &&& x <<< 8#16 != 0) = true) →
      truncate 16 (zeroExtend 32 x >>> 9#32 ||| zeroExtend 32 x <<< 8#32) = x >>> 9#16 ||| x <<< 8#16 :=
sorry