
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

theorem trunc_shl_zext_32_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬4#16 ≥ ↑16 → ¬4#32 ≥ ↑32 → zeroExtend 32 (truncate 16 x <<< 4#16) = x <<< 4#32 &&& 65520#32 :=
sorry