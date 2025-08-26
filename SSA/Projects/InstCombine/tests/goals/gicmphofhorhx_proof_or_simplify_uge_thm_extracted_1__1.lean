
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

theorem or_simplify_uge_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x ||| BitVec.ofInt 8 (-127) ||| x_1 &&& 127#8 ≤ᵤ x_1 &&& 127#8) = 0#1 :=
sorry