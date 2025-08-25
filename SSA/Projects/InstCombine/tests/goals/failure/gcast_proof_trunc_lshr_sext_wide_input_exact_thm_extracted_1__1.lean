
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

theorem trunc_lshr_sext_wide_input_exact_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(True ∧ signExtend 32 x >>> 9#32 <<< 9#32 ≠ signExtend 32 x ∨ 9#32 ≥ ↑32) →
    True ∧ x >>> 9#16 <<< 9#16 ≠ x ∨
        9#16 ≥ ↑16 ∨ True ∧ signExtend 16 (truncate 8 (x.sshiftRight' 9#16)) ≠ x.sshiftRight' 9#16 →
      False :=
sorry