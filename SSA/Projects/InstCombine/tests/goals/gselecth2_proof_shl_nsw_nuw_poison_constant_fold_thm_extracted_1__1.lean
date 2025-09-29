
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

theorem shl_nsw_nuw_poison_constant_fold_thm.extracted_1._1 : ∀ (x : BitVec 1),
  x = 1#1 →
    ¬(True ∧ (16#8 <<< 3#8).sshiftRight' 3#8 ≠ 16#8 ∨ True ∧ 16#8 <<< 3#8 >>> 3#8 ≠ 16#8 ∨ 3#8 ≥ ↑8) →
      16#8 <<< 3#8 = BitVec.ofInt 8 (-128) :=
sorry