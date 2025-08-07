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

theorem modulo32_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(32#32 == 0 || 32 != 1 && x == intMin 32 && 32#32 == -1) = true →
    ¬ofBool (x.srem 32#32 <ₛ 0#32) = 1#1 →
      ¬((32#32 == 0 || 32 != 1 && x == intMin 32 && 32#32 == -1) = true ∨
            True ∧ (0#32).saddOverflow (x.srem 32#32) = true) →
        0#32 + x.srem 32#32 = x &&& 31#32 :=
sorry