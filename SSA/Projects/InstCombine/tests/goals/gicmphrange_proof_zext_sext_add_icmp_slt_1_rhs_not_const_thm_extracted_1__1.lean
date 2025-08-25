
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

theorem zext_sext_add_icmp_slt_1_rhs_not_const_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 x_2 : BitVec 1),
  True ∧ (zeroExtend 8 x_2).saddOverflow (signExtend 8 x_1) = true → False :=
sorry