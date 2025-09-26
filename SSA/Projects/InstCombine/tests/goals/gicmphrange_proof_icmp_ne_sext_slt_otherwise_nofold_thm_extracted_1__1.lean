
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

theorem icmp_ne_sext_slt_otherwise_nofold_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (signExtend 32 (ofBool (x <ₛ 2#32)) != x) = ofBool (x != signExtend 32 (ofBool (x <ₛ 2#32))) :=
sorry