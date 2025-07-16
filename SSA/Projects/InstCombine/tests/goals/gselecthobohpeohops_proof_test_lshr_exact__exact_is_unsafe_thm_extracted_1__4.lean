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

theorem test_lshr_exact__exact_is_unsafe_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 63#32 == 0#32) = 1#1 →
    ¬(True ∧ (x_1 &&& 63#32) >>> 2#32 <<< 2#32 ≠ x_1 &&& 63#32 ∨
          2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 63#32) >>> 2#32) ≥ ↑64) →
      ¬(2#32 ≥ ↑32 ∨ True ∧ (x_1 >>> 2#32 &&& 15#32).msb = true ∨ zeroExtend 64 (x_1 >>> 2#32 &&& 15#32) ≥ ↑64) →
        x.sshiftRight' (zeroExtend 64 ((x_1 &&& 63#32) >>> 2#32)) =
          x.sshiftRight' (zeroExtend 64 (x_1 >>> 2#32 &&& 15#32)) :=
sorry