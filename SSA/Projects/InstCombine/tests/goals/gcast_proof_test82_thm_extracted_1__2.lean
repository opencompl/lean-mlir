
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
import SSA.Projects.InstCombine.TacticAuto
import LeanMLIR.Dialects.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false
-/

theorem test82_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬(8#32 ≥ ↑32 ∨ 9#32 ≥ ↑32) →
    ¬1#32 ≥ ↑32 →
      zeroExtend 64 (truncate 32 x >>> 8#32 <<< 9#32) =
        zeroExtend 64 (truncate 32 x <<< 1#32 &&& BitVec.ofInt 32 (-512)) :=
sorry