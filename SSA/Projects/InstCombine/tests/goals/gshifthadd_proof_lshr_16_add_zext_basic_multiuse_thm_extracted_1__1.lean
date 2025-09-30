
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
import SSA.Projects.InstCombine.TacticAuto
import LeanMLIR.Dialects.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false
-/

theorem lshr_16_add_zext_basic_multiuse_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬16#32 ≥ ↑32 →
    True ∧ (zeroExtend 32 x_1).saddOverflow (zeroExtend 32 x) = true ∨
        True ∧ (zeroExtend 32 x_1).uaddOverflow (zeroExtend 32 x) = true ∨ 16#32 ≥ ↑32 →
      False :=
sorry