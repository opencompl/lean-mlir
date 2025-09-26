
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

theorem src_is_mask_lshr_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 1) (x_2 : BitVec 8),
  ¬x_1 = 1#1 →
    ¬x ≥ ↑8 → ofBool (x_2 ^^^ 123#8 != 15#8 >>> x &&& (x_2 ^^^ 123#8)) = ofBool (15#8 >>> x <ᵤ x_2 ^^^ 123#8) :=
sorry