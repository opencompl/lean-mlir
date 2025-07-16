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

theorem shl_sub_i64_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬63#64 - x ≥ ↑64 →
    ¬(True ∧ BitVec.ofInt 64 (-9223372036854775808) >>> x <<< x ≠ BitVec.ofInt 64 (-9223372036854775808) ∨ x ≥ ↑64) →
      1#64 <<< (63#64 - x) = BitVec.ofInt 64 (-9223372036854775808) >>> x :=
sorry