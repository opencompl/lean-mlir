
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

theorem lshr_32_add_zext_basic_multiuse_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬32#64 ≥ ↑64 →
    True ∧ (zeroExtend 64 x_1).saddOverflow (zeroExtend 64 x) = true ∨
        True ∧ (zeroExtend 64 x_1).uaddOverflow (zeroExtend 64 x) = true ∨ 32#64 ≥ ↑64 →
      False :=
sorry