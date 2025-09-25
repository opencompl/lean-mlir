
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

theorem xor_andn_commute3_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(x_1 = 0 ∨ x_1 = 0) → ¬x_1 = 0 → 42#32 / x_1 ^^^ (42#32 / x_1 ^^^ -1#32) &&& x = 42#32 / x_1 ||| x :=
sorry