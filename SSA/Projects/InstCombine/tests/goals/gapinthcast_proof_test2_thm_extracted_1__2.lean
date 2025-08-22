
/-
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
-/

theorem test2_thm.extracted_1._2 : ∀ (x : BitVec 167),
  ¬(9#577 ≥ ↑577 ∨ 8#577 ≥ ↑577) →
    ¬(9#167 ≥ ↑167 ∨ 8#167 ≥ ↑167) →
      truncate 167 (zeroExtend 577 x >>> 9#577 ||| zeroExtend 577 x <<< 8#577) = x >>> 9#167 ||| x <<< 8#167 :=
sorry