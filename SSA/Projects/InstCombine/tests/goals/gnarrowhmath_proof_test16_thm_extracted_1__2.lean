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

theorem test16_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬1#32 ≥ ↑32 →
    ¬(1#32 ≥ ↑32 ∨ True ∧ (BitVec.ofInt 32 (-2)).usubOverflow (x >>> 1#32) = true) →
      4294967294#64 - zeroExtend 64 (x >>> 1#32) = zeroExtend 64 (BitVec.ofInt 32 (-2) - x >>> 1#32) :=
sorry