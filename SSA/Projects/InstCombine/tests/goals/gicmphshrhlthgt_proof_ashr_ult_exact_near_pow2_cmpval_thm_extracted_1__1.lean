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

theorem ashr_ult_exact_near_pow2_cmpval_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x >>> 1#8 <<< 1#8 ≠ x ∨ 1#8 ≥ ↑8) → ofBool (x.sshiftRight' 1#8 <ᵤ 5#8) = ofBool (x <ᵤ 9#8) :=
sorry