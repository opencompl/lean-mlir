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

theorem ashr_lshr_cst2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (-1#32 <ₛ x) = 1#1 → ¬8#32 ≥ ↑32 → x >>> 8#32 = x.sshiftRight' 8#32 :=
sorry