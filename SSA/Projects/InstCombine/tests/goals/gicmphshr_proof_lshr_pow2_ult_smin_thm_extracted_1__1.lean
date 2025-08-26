
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

theorem lshr_pow2_ult_smin_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬x ≥ ↑8 → ofBool (BitVec.ofInt 8 (-128) >>> x <ᵤ BitVec.ofInt 8 (-128)) = ofBool (x != 0#8) :=
sorry