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

theorem trunc_shl_ashr_infloop_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬(3#64 ≥ ↑64 ∨ 2#64 ≥ ↑64) →
    ¬1#64 ≥ ↑64 → truncate 32 (x.sshiftRight' 3#64 <<< 2#64) = truncate 32 (x >>> 1#64) &&& BitVec.ofInt 32 (-4) :=
sorry