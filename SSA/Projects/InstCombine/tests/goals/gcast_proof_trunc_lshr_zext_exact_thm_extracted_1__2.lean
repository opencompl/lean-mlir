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

theorem trunc_lshr_zext_exact_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(True ∧ zeroExtend 32 x >>> 6#32 <<< 6#32 ≠ zeroExtend 32 x ∨ 6#32 ≥ ↑32) →
    ¬6#8 ≥ ↑8 → truncate 8 (zeroExtend 32 x >>> 6#32) = x >>> 6#8 :=
sorry