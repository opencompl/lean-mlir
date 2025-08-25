
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

theorem urem_i32_multiuse_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬zeroExtend 32 x = 0 →
    zeroExtend 32 x = 0 ∨
        True ∧ (zeroExtend 32 x_1).saddOverflow (zeroExtend 32 x) = true ∨
          True ∧ (zeroExtend 32 x_1).uaddOverflow (zeroExtend 32 x) = true ∨
            True ∧ (zeroExtend 32 x_1 % zeroExtend 32 x).smulOverflow (zeroExtend 32 x_1 + zeroExtend 32 x) = true ∨
              True ∧ (zeroExtend 32 x_1 % zeroExtend 32 x).umulOverflow (zeroExtend 32 x_1 + zeroExtend 32 x) = true →
      False :=
sorry