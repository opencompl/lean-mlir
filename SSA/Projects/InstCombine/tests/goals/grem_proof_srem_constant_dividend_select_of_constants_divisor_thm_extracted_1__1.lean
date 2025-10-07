
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

theorem srem_constant_dividend_select_of_constants_divisor_thm.extracted_1._1 : ∀ (x : BitVec 1),
  x = 1#1 → ¬(12#32 == 0 || 32 != 1 && 42#32 == intMin 32 && 12#32 == -1) = true → (42#32).srem 12#32 = 6#32 :=
sorry