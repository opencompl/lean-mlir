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

theorem shl_nsw_add_negative_invalid_constant3_thm.extracted_1._2 : ∀ (x : BitVec 4),
  ¬(True ∧ (2#4 <<< (x + BitVec.ofInt 4 (-8))).sshiftRight' (x + BitVec.ofInt 4 (-8)) ≠ 2#4 ∨
        x + BitVec.ofInt 4 (-8) ≥ ↑4) →
    ¬(True ∧ (2#4 <<< (x ^^^ BitVec.ofInt 4 (-8))).sshiftRight' (x ^^^ BitVec.ofInt 4 (-8)) ≠ 2#4 ∨
          x ^^^ BitVec.ofInt 4 (-8) ≥ ↑4) →
      2#4 <<< (x + BitVec.ofInt 4 (-8)) = 2#4 <<< (x ^^^ BitVec.ofInt 4 (-8)) :=
sorry