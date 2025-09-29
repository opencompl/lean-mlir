
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

theorem OrZextOr_thm.extracted_1._1 : ∀ (x : BitVec 3), zeroExtend 5 (x ||| 3#3) ||| 8#5 = zeroExtend 5 x ||| 11#5 :=
sorry