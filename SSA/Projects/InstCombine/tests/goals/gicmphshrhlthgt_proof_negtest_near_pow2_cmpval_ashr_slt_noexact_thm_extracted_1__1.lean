
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

theorem negtest_near_pow2_cmpval_ashr_slt_noexact_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬1#8 ≥ ↑8 → ofBool (x.sshiftRight' 1#8 <ₛ 5#8) = ofBool (x <ₛ 10#8) :=
sorry