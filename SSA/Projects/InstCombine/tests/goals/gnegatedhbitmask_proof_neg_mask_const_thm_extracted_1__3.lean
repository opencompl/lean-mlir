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

theorem neg_mask_const_thm.extracted_1._3 : ∀ (x : BitVec 16),
  ¬(True ∧ (1000#32).ssubOverflow (signExtend 32 x) = true ∨
        15#16 ≥ ↑16 ∨ True ∧ (0#32).ssubOverflow (zeroExtend 32 (x >>> 15#16)) = true) →
    ¬ofBool (x <ₛ 0#16) = 1#1 → 1000#32 - signExtend 32 x &&& 0#32 - zeroExtend 32 (x >>> 15#16) = 0#32 :=
sorry