
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

theorem C0zero_thm.extracted_1._8 : ∀ (x x_1 x_2 : BitVec 8),
  ofBool (x_2 + 10#8 <ᵤ 0#8) = 1#1 → ¬ofBool (x_2 <ₛ BitVec.ofInt 8 (-10)) = 1#1 → x_2 = x :=
sorry