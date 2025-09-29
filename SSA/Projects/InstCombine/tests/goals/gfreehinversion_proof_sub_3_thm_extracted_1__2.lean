
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

theorem sub_3_thm.extracted_1._2 : ∀ (x : BitVec 128) (x_1 : BitVec 1) (x_2 : BitVec 128),
  ¬x_1 = 1#1 → x_2 - (x ^^^ 123#128) ^^^ -1#128 = BitVec.ofInt 128 (-2) - ((x ^^^ BitVec.ofInt 128 (-124)) + x_2) :=
sorry