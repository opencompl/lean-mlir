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

theorem shl_nsw_add_nuw_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ x.uaddOverflow 1#32 = true ∨
        True ∧ ((-1#32) <<< (x + 1#32)).sshiftRight' (x + 1#32) ≠ -1#32 ∨ x + 1#32 ≥ ↑32) →
    ¬(True ∧ (BitVec.ofInt 32 (-2) <<< x).sshiftRight' x ≠ BitVec.ofInt 32 (-2) ∨ x ≥ ↑32) →
      (-1#32) <<< (x + 1#32) = BitVec.ofInt 32 (-2) <<< x :=
sorry