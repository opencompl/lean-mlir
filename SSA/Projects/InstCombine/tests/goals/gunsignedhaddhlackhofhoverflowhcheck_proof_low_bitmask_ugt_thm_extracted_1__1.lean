
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

theorem low_bitmask_ugt_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (x * x + 127#8 &&& 127#8 <ᵤ x * x) = ofBool (x * x != 0#8) :=
sorry