
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

theorem pr89516_thm.extracted_1._4 : ∀ (x x_1 : BitVec 8),
  ¬ofBool (x_1 <ₛ 0#8) = 1#1 →
    ¬(True ∧ 1#8 <<< x >>> x ≠ 1#8 ∨ x ≥ ↑8 ∨ (1#8 <<< x == 0 || 8 != 1 && 1#8 == intMin 8 && 1#8 <<< x == -1) = true) →
      True ∧ ((1#8).srem (1#8 <<< x)).uaddOverflow 0#8 = true → False :=
sorry