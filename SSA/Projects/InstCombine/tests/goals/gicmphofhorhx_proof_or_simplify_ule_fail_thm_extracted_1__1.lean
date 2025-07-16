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

theorem or_simplify_ule_fail_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 ||| 64#8 ||| x &&& 127#8 ≤ᵤ x &&& 127#8) = ofBool (x_1 ||| x &&& 127#8 ||| 64#8 ≤ᵤ x &&& 127#8) :=
sorry