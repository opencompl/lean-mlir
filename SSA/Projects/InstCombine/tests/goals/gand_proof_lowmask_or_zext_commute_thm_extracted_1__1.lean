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

theorem lowmask_or_zext_commute_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 24),
  (x_1 ||| zeroExtend 24 x) &&& 65535#24 = zeroExtend 24 (x ||| truncate 16 x_1) :=
sorry