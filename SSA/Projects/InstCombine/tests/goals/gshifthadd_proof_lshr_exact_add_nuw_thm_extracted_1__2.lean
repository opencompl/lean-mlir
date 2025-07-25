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

theorem lshr_exact_add_nuw_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ x.uaddOverflow 1#32 = true ∨ True ∧ 4#32 >>> (x + 1#32) <<< (x + 1#32) ≠ 4#32 ∨ x + 1#32 ≥ ↑32) →
    ¬(True ∧ 2#32 >>> x <<< x ≠ 2#32 ∨ x ≥ ↑32) → 4#32 >>> (x + 1#32) = 2#32 >>> x :=
sorry