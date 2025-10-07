
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

theorem exactly_one_set_signbit_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬7#8 ≥ ↑8 → ofBool (x_1 >>> 7#8 == zeroExtend 8 (ofBool (-1#8 <ₛ x))) = ofBool (x_1 ^^^ x <ₛ 0#8) :=
sorry