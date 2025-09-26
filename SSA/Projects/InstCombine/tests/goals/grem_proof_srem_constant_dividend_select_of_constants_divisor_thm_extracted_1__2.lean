
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

theorem srem_constant_dividend_select_of_constants_divisor_thm.extracted_1._2 : ∀ (x : BitVec 1),
  ¬x = 1#1 →
    ¬(BitVec.ofInt 32 (-3) == 0 || 32 != 1 && 42#32 == intMin 32 && BitVec.ofInt 32 (-3) == -1) = true →
      (42#32).srem (BitVec.ofInt 32 (-3)) = 0#32 :=
sorry