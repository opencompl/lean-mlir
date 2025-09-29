
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

theorem test31_thm.extracted_1._1 : ∀ (x : BitVec 1),
  ¬4#32 ≥ ↑32 → x = 1#1 → zeroExtend 32 x <<< 4#32 &&& 16#32 = 16#32 :=
sorry