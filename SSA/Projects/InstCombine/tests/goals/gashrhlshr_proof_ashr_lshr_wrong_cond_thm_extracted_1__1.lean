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

theorem ashr_lshr_wrong_cond_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (-1#32 ≤ₛ x_1) = 1#1 →
    ¬x ≥ ↑32 → ¬ofBool (BitVec.ofInt 32 (-2) <ₛ x_1) = 1#1 → x_1 >>> x = x_1.sshiftRight' x :=
sorry