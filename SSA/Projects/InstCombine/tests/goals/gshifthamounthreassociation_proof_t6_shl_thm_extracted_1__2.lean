
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

theorem t6_shl_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ x_1 <<< (32#32 - x) >>> (32#32 - x) ≠ x_1 ∨
        32#32 - x ≥ ↑32 ∨
          True ∧
              (x_1 <<< (32#32 - x) <<< (x + BitVec.ofInt 32 (-2))).sshiftRight' (x + BitVec.ofInt 32 (-2)) ≠
                x_1 <<< (32#32 - x) ∨
            x + BitVec.ofInt 32 (-2) ≥ ↑32) →
    ¬30#32 ≥ ↑32 → x_1 <<< (32#32 - x) <<< (x + BitVec.ofInt 32 (-2)) = x_1 <<< 30#32 :=
sorry