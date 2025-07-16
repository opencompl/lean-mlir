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

theorem ne_21_comm_ne_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(16#32 ≥ ↑32 ∨ 16#32 ≥ ↑32 ∨ 8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
    ¬(8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
      ofBool (truncate 8 (x_1 >>> 16#32) != truncate 8 (x >>> 16#32)) |||
          ofBool (truncate 8 (x >>> 8#32) != truncate 8 (x_1 >>> 8#32)) =
        ofBool (truncate 16 (x_1 >>> 8#32) != truncate 16 (x >>> 8#32)) :=
sorry