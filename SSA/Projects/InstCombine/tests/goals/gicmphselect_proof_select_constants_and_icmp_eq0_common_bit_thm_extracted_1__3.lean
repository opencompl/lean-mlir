
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

theorem select_constants_and_icmp_eq0_common_bit_thm.extracted_1._3 : ∀ (x x_1 : BitVec 1),
  ¬x_1 = 1#1 → x = 1#1 → ofBool (3#8 &&& 2#8 == 0#8) = 0#1 :=
sorry