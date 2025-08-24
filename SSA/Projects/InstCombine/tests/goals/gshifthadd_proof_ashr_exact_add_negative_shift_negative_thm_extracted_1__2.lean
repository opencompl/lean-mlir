
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

theorem ashr_exact_add_negative_shift_negative_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ BitVec.ofInt 32 (-2) >>> (x + -1#32) <<< (x + -1#32) ≠ BitVec.ofInt 32 (-2) ∨ x + -1#32 ≥ ↑32) →
    ¬(True ∧ BitVec.ofInt 32 (-4) >>> x <<< x ≠ BitVec.ofInt 32 (-4) ∨ x ≥ ↑32) →
      (BitVec.ofInt 32 (-2)).sshiftRight' (x + -1#32) = (BitVec.ofInt 32 (-4)).sshiftRight' x :=
sorry