
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

theorem or_zext_zext_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 4),
  zeroExtend 16 x_1 ||| zeroExtend 16 x = zeroExtend 16 (x ||| zeroExtend 8 x_1) :=
sorry