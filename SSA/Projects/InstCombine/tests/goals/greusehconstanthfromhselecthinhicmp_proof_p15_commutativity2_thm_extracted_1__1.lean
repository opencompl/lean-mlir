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

theorem p15_commutativity2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x <ᵤ 65536#32) = 1#1 → ofBool (65535#32 <ᵤ x) = 1#1 → 42#32 = 65535#32 :=
sorry