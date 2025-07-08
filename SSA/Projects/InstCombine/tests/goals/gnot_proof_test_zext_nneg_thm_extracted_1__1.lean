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

theorem test_zext_nneg_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32) (x_2 : BitVec 64),
  ¬(True ∧ (x_1 ^^^ -1#32).msb = true) →
    x_2 + BitVec.ofInt 64 (-5) - (zeroExtend 64 (x_1 ^^^ -1#32) + x) =
      x_2 + BitVec.ofInt 64 (-4) + (signExtend 64 x_1 - x) :=
sorry