
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

theorem badimm2_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(6#8 ≥ ↑8 ∨ 8#16 ≥ ↑16) →
    ¬ofBool ((truncate 8 x).sshiftRight' 6#8 == truncate 8 (x >>> 8#16)) = 1#1 →
      ¬15#16 ≥ ↑16 → 6#8 ≥ ↑8 ∨ 8#16 ≥ ↑16 ∨ True ∧ zeroExtend 16 (truncate 8 (x >>> 8#16)) ≠ x >>> 8#16 → False :=
sorry