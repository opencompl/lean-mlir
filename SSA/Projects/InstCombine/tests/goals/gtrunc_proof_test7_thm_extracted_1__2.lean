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

theorem test7_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬32#128 ≥ ↑128 →
    ¬(32#64 ≥ ↑64 ∨ True ∧ (x >>> 32#64).msb = true) →
      truncate 92 (zeroExtend 128 x >>> 32#128) = zeroExtend 92 (x >>> 32#64) :=
sorry