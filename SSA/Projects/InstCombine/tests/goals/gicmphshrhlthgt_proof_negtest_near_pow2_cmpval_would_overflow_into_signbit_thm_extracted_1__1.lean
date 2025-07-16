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

theorem negtest_near_pow2_cmpval_would_overflow_into_signbit_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x >>> 2#8 <<< 2#8 ≠ x ∨ 2#8 ≥ ↑8) → ofBool (x.sshiftRight' 2#8 <ᵤ 33#8) = ofBool (-1#8 <ₛ x) :=
sorry