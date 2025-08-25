
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

theorem and_two_ranges_to_mask_and_range_no_add_on_one_range_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ofBool (12#16 ≤ᵤ x) &&& (ofBool (x <ᵤ 16#16) ||| ofBool (28#16 ≤ᵤ x)) =
    ofBool (11#16 <ᵤ x &&& BitVec.ofInt 16 (-20)) :=
sorry