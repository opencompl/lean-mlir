
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

theorem src_is_notmask_ashr_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 8) (x_2 : BitVec 16),
  ¬(x_1 ≥ ↑8 ∨ x ≥ ↑16) →
    ofBool
        (x_2 ^^^ 123#16 ==
          (x_2 ^^^ 123#16) &&& ((signExtend 16 (BitVec.ofInt 8 (-32) <<< x_1)).sshiftRight' x ^^^ -1#16)) =
      ofBool ((signExtend 16 (BitVec.ofInt 8 (-32) <<< x_1)).sshiftRight' x ≤ᵤ x_2 ^^^ BitVec.ofInt 16 (-124)) :=
sorry