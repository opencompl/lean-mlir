
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

theorem icmp_x_slt_0_xor_icmp_y_sgt_neg1_i32_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬31#32 ≥ ↑32 → x_1 >>> 31#32 ^^^ zeroExtend 32 (ofBool (-1#32 <ₛ x)) = zeroExtend 32 (ofBool (-1#32 <ₛ x_1 ^^^ x)) :=
sorry