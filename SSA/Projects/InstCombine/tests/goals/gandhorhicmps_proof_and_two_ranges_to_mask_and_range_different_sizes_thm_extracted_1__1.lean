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

theorem and_two_ranges_to_mask_and_range_different_sizes_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (25#8 <ᵤ x + BitVec.ofInt 8 (-97)) &&& ofBool (24#8 <ᵤ x + BitVec.ofInt 8 (-65)) =
    ofBool (x + BitVec.ofInt 8 (-123) <ᵤ BitVec.ofInt 8 (-26)) &&&
      ofBool (x + BitVec.ofInt 8 (-90) <ᵤ BitVec.ofInt 8 (-25)) :=
sorry