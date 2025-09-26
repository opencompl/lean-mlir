
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

theorem or_not_xor_common_op_commute6_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 8),
  x_2 ^^^ x_1 ||| (0#8 - x ||| x_1 ^^^ -1#8) = x_2 &&& x_1 ^^^ -1#8 ||| 0#8 - x :=
sorry