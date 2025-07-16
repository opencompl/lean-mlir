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

theorem trunc_shl_lshr_var_thm.extracted_1._2 : ∀ (x x_1 : BitVec 64),
  ¬(x ≥ ↑64 ∨ 2#64 ≥ ↑64) →
    ¬(x ≥ ↑64 ∨ 2#32 ≥ ↑32) → truncate 32 (x_1 >>> x <<< 2#64) = truncate 32 (x_1 >>> x) <<< 2#32 :=
sorry