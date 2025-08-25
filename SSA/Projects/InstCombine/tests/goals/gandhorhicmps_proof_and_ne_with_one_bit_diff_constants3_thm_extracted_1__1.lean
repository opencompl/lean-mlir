
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

theorem and_ne_with_one_bit_diff_constants3_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (x != 65#8) &&& ofBool (x != BitVec.ofInt 8 (-63)) = ofBool (x &&& 127#8 != 65#8) :=
sorry