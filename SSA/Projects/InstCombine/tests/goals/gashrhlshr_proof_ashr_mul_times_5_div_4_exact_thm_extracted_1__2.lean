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

theorem ashr_mul_times_5_div_4_exact_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ x.smulOverflow 5#32 = true ∨ True ∧ (x * 5#32) >>> 2#32 <<< 2#32 ≠ x * 5#32 ∨ 2#32 ≥ ↑32) →
    ¬(True ∧ x >>> 2#32 <<< 2#32 ≠ x ∨ 2#32 ≥ ↑32 ∨ True ∧ x.saddOverflow (x.sshiftRight' 2#32) = true) →
      (x * 5#32).sshiftRight' 2#32 = x + x.sshiftRight' 2#32 :=
sorry