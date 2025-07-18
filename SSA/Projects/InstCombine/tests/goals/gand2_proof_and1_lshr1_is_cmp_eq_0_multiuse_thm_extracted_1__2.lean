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

theorem and1_lshr1_is_cmp_eq_0_multiuse_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(x ≥ ↑8 ∨ x ≥ ↑8) →
    ¬(x ≥ ↑8 ∨
          True ∧ (1#8 >>> x <<< 1#8).sshiftRight' 1#8 ≠ 1#8 >>> x ∨
            True ∧ 1#8 >>> x <<< 1#8 >>> 1#8 ≠ 1#8 >>> x ∨ 1#8 ≥ ↑8) →
      1#8 >>> x + (1#8 >>> x &&& 1#8) = 1#8 >>> x <<< 1#8 :=
sorry