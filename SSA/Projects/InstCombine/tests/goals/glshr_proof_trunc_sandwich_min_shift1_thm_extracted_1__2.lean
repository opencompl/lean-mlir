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

theorem trunc_sandwich_min_shift1_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(20#32 ≥ ↑32 ∨ 1#12 ≥ ↑12) →
    ¬(21#32 ≥ ↑32 ∨
          True ∧ signExtend 32 (truncate 12 (x >>> 21#32)) ≠ x >>> 21#32 ∨
            True ∧ zeroExtend 32 (truncate 12 (x >>> 21#32)) ≠ x >>> 21#32) →
      truncate 12 (x >>> 20#32) >>> 1#12 = truncate 12 (x >>> 21#32) :=
sorry