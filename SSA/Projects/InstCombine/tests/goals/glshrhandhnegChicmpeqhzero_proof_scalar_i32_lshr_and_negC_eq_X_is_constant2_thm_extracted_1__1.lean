
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

theorem scalar_i32_lshr_and_negC_eq_X_is_constant2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → ofBool (268435456#32 >>> x &&& BitVec.ofInt 32 (-8) == 0#32) = ofBool (25#32 <ᵤ x) :=
sorry