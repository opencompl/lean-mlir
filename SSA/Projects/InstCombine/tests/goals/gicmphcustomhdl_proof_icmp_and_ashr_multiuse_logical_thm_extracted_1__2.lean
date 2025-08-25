
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

theorem icmp_and_ashr_multiuse_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬4#32 ≥ ↑32 →
    ¬ofBool (x.sshiftRight' 4#32 &&& 15#32 != 14#32) = 1#1 →
      0#1 = ofBool (x &&& 240#32 != 224#32) &&& ofBool (x &&& 496#32 != 432#32) :=
sorry