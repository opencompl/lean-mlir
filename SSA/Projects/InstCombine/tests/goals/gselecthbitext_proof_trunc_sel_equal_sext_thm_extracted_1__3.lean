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

theorem trunc_sel_equal_sext_thm.extracted_1._3 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  x_1 = 1#1 →
    ¬(16#32 ≥ ↑32 ∨ True ∧ x <<< 16#32 >>> 16#32 <<< 16#32 ≠ x <<< 16#32 ∨ 16#32 ≥ ↑32) →
      signExtend 32 (truncate 16 x) = (x <<< 16#32).sshiftRight' 16#32 :=
sorry