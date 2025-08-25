
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

theorem narrow_zext_ashr_keep_trunc3_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ (signExtend 64 x_1).saddOverflow (signExtend 64 x) = true ∨ 1#64 ≥ ↑64) →
    True ∧ (zeroExtend 14 x_1).saddOverflow (zeroExtend 14 x) = true ∨
        True ∧ (zeroExtend 14 x_1).uaddOverflow (zeroExtend 14 x) = true ∨ 1#14 ≥ ↑14 →
      False :=
sorry