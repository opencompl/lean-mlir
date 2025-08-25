
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

theorem fold_nested_logic_zext_icmp_thm.extracted_1._1 : ∀ (x x_1 x_2 x_3 : BitVec 64),
  zeroExtend 8 (ofBool (x_2 <ₛ x_3)) &&& zeroExtend 8 (ofBool (x_3 <ₛ x_1)) ||| zeroExtend 8 (ofBool (x_3 == x)) =
    zeroExtend 8 (ofBool (x_2 <ₛ x_3) &&& ofBool (x_3 <ₛ x_1) ||| ofBool (x_3 == x)) :=
sorry