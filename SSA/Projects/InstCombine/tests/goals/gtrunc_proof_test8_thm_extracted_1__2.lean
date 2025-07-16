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

theorem test8_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬32#128 ≥ ↑128 →
    ¬(True ∧ zeroExtend 64 x_1 <<< 32#64 >>> 32#64 ≠ zeroExtend 64 x_1 ∨
          32#64 ≥ ↑64 ∨ True ∧ (zeroExtend 64 x_1 <<< 32#64 &&& zeroExtend 64 x != 0) = true) →
      truncate 64 (zeroExtend 128 x_1 <<< 32#128 ||| zeroExtend 128 x) =
        zeroExtend 64 x_1 <<< 32#64 ||| zeroExtend 64 x :=
sorry