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

theorem scalar_i8_lshr_and_negC_eq_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬x ≥ ↑8 → ofBool (x_1 >>> x &&& BitVec.ofInt 8 (-4) == 0#8) = ofBool (x_1 >>> x <ᵤ 4#8) :=
sorry