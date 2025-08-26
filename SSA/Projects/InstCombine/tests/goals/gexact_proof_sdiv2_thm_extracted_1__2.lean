
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

theorem sdiv2_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ x.smod 8#32 ≠ 0 ∨ (8#32 == 0 || 32 != 1 && x == intMin 32 && 8#32 == -1) = true) →
    ¬(True ∧ x >>> 3#32 <<< 3#32 ≠ x ∨ 3#32 ≥ ↑32) → x.sdiv 8#32 = x.sshiftRight' 3#32 :=
sorry