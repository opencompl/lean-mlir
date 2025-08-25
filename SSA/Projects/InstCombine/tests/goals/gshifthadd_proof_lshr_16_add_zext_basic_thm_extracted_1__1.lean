
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

theorem lshr_16_add_zext_basic_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬16#32 ≥ ↑32 → (zeroExtend 32 x_1 + zeroExtend 32 x) >>> 16#32 = zeroExtend 32 (ofBool (x_1 ^^^ -1#16 <ᵤ x)) :=
sorry