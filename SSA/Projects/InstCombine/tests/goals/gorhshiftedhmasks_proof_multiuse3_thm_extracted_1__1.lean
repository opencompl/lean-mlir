
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

theorem multiuse3_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ (x &&& 96#32) >>> 1#32 <<< 1#32 ≠ x &&& 96#32 ∨
        1#32 ≥ ↑32 ∨
          1#32 ≥ ↑32 ∨
            True ∧ ((x &&& 96#32) <<< 6#32).sshiftRight' 6#32 ≠ x &&& 96#32 ∨
              True ∧ (x &&& 96#32) <<< 6#32 >>> 6#32 ≠ x &&& 96#32 ∨ 6#32 ≥ ↑32 ∨ 6#32 ≥ ↑32) →
    1#32 ≥ ↑32 ∨
        1#32 ≥ ↑32 ∨
          True ∧ (x >>> 1#32 &&& 48#32 &&& (x >>> 1#32 &&& 15#32) != 0) = true ∨
            6#32 ≥ ↑32 ∨
              True ∧ ((x >>> 1#32 &&& 48#32 ||| x >>> 1#32 &&& 15#32) &&& (x <<< 6#32 &&& 8064#32) != 0) = true →
      False :=
sorry