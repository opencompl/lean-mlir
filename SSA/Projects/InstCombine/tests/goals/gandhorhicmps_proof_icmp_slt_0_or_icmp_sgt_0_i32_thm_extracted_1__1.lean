
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

theorem icmp_slt_0_or_icmp_sgt_0_i32_thm.extracted_1._1 : ∀ (x : BitVec 32),
  zeroExtend 32 (ofBool (x <ₛ 0#32)) ||| zeroExtend 32 (ofBool (0#32 <ₛ x)) = zeroExtend 32 (ofBool (x != 0#32)) :=
sorry